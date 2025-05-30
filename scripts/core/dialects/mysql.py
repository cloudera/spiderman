import datetime
from typing import List

from sqlglot import exp, parse_one, Dialects

from core.source_db import Table, Column


# --- Schema --------------------------------------------------------
INDENTATION = "    "

def _correct_type(col: Column) -> str:
    col_type = col.type.upper()

    if col_type.startswith("NUMBER"):
        col_type = col_type.replace("NUMBER", "NUMERIC")

    if col_type.startswith("VARCHAR2"):
        col_type = col_type.replace("VARCHAR2", "VARCHAR")

    if col_type.startswith("CHARACTER VARCHAR"):
        col_type = col_type.replace("CHARACTER VARCHAR", "VARCHAR")

    if col_type == "TIMESTAMP":
        col_type = "DATETIME"

    if col.is_primary_key and col_type == "TEXT":
        col_type = "VARCHAR(50)"

    if col.is_unique and col_type == "TEXT":
        col_type = "VARCHAR(50)"

    return col_type

def _build_column_definition(table: Table) -> List[str]:
    column_def = []

    for col in table.columns:
        col_type = _correct_type(col)
        col_details = f"{INDENTATION}`{col.name}` {col_type}"

        if col.is_not_null:
            col_details = col_details + " NOT NULL"

        if col.default_val != None and not col.is_primary_key:
            # String literals in the schema must be enclosed in single quotes
            col_default_val = col.default_val.replace("`", "'")
            col_details = col_details + f" DEFAULT {col_default_val}"

        column_def.append(col_details)

    return column_def

def _build_primary_key_constraints(table: Table) -> List[str]:
    pk_constraint = []

    pk_col_names = []
    for col in table.columns:
        if col.is_primary_key:
            pk_col_names.append(f"`{col.name}`")

    if pk_col_names:
        pk_col_names_str = ", ".join(pk_col_names)
        pk_constraint.append(f"{INDENTATION}PRIMARY KEY ({pk_col_names_str})")

    return pk_constraint

def _build_foreign_key_constraints(table: Table) -> List[str]:
    fk_constraints = []

    for fk in table.foreign_keys:
        from_columns_str = ", ".join([f"`{name}`" for name in fk.from_columns])
        to_columns_str = ", ".join([f"`{name}`" for name in fk.to_columns])
        fk_constraints.append(f"{INDENTATION}FOREIGN KEY ({from_columns_str}) REFERENCES `{table.db_name}`.`{fk.to_table}` ({to_columns_str})")

    return fk_constraints

def _build_unique_constraints(table: Table) -> List[str]:
    unique_constraints = []

    for col in table.columns:
        if col.is_unique:
            unique_constraints.append(f'{INDENTATION}UNIQUE (`{col.name}`)')

    return unique_constraints

def _build_index_def(table: Table) -> List[str]:
    index_defs = []

    for col in table.columns:
        if col.is_indexed:
            index_defs.append(f'{INDENTATION}INDEX idx_{col.name} (`{col.name}`)')

    return index_defs

def build_table_ddl(table: Table) -> str:
    table_defs = []
    table_defs += _build_column_definition(table)
    table_defs += _build_primary_key_constraints(table)
    table_defs += _build_foreign_key_constraints(table)
    table_defs += _build_unique_constraints(table)
    table_defs += _build_index_def(table)

    defs_str = ",\n".join(table_defs)
    return f"""CREATE TABLE `{table.db_name}`.`{table.name}` (
{defs_str}
);"""


# --- Data ----------------------------------------------------------
def _order_columns(columns: list[Column], column_name: list[str]) -> list[Column]:
    column_map = {}
    for col in columns:
        column_map[col.name] = col

    return [column_map[name] for name in column_name]

DATE_FORMAT = '%Y-%m-%d'
def normalize_data(table_data: list[list], table: Table) -> list[list]:
    column_names: list = table_data[0]
    columns = _order_columns(table.columns, column_names)

    rows: list[list] = table_data[1:]
    for row in rows:
        for idx in range(len(column_names)):
            column = columns[idx]
            value = row[idx]
            type = column.type.upper()

            if isinstance(value, str):
                value = value.strip()

            if value == "nil" or value == None:
                value = ""

            if value == "" and not column.is_not_null:
                value = "NULL"

            if value == "" and type in ["INT"]:
                value = "NULL"

            if type == "DATE":
                try:
                    value = datetime.datetime.strptime(value, '%d/%m/%Y %H:%M').strftime(DATE_FORMAT)
                except:
                    try:
                        value = datetime.datetime.strptime(value, '%d-%b-%Y').strftime(DATE_FORMAT)
                    except:
                        pass
                        # Use value as it is

            row[idx] = value

    return [column_names] + rows


# --- Query ---------------------------------------------------------

# Correct table names - Queries in the source have case inconsistency issues with table names
def _table_transformer(node, valid_table_name_map: dict[str, str]):
    if isinstance(node, exp.Table):
        name_key = node.name.lower()
        if name_key in valid_table_name_map:
            node_str = str(node)
            node_str = node_str.replace(node.name, valid_table_name_map[name_key])
            return parse_one(node_str)
    return node

def _has_aggregated_function(node) -> bool:
    for select in node.selects:
        if isinstance(select, exp.Min): return True
        if isinstance(select, exp.Max): return True
        if isinstance(select, exp.Count): return True
        if isinstance(select, exp.Avg): return True
    return False

# Add missing Group Bys
def _group_by_transformer(node):
    if isinstance(node, exp.Select):
        node_str = str(node).upper()
        if "GROUP BY" in node_str or _has_aggregated_function(node):
            columns = []
            for select in node.selects:
                if isinstance(select, exp.Column):
                    columns.append(str(select))
            if columns:
                return node.group_by(", ".join(columns), append = False)
    return node

# Make all aliases into lower case - Alias in source have case inconsistency issues
def _alias_transformer(node, valid_table_names: list[str]):
    is_alias = False

    # Inside FROM
    if isinstance(node, exp.TableAlias):
        is_alias = True

    # Inside WHERE clauses
    if isinstance(node.parent, exp.Column) and str(node) == str(node.parent.table):
        is_alias = True

    if is_alias:
        node_str = str(node)
        if node_str not in valid_table_names:
            normalized_alias = node_str.lower()
            if node_str != normalized_alias:
                return parse_one(normalized_alias)

    return node

# Split FROM with multiple tables into JOIN - FROM XTable x, YTable y JOIN ZTable z → FROM XTable x JOIN YTable y JOIN ZTable z
def _join_transformer(sql: str) -> str:
    # Couldn't force sqlglot to avoid comma separated join hence this hack

    sub_sqls = sql.split("SELECT")

    final_sqls = []
    for sub_sql in sub_sqls:
        sql_upper = sub_sql.upper()
        from_index = sql_upper.find(" FROM ")
        last_join_index = sql_upper.rfind(" JOIN ")

        if from_index != -1 and last_join_index != -1:
            # Replace , in between FROM and JOIN to JOIN
            segment = sub_sql[from_index:last_join_index]
            segment = segment.replace(", ", " JOIN ")
            sub_sql = sub_sql[:from_index] + segment + sub_sql[last_join_index:]

        final_sqls.append(sub_sql)

    return "SELECT".join(final_sqls)

def _get_name_map(table_names: list[str]) -> dict[str, str]:
    table_name_map: dict[str, str] = {}
    for table_name in table_names:
        name_key = table_name.lower()
        table_name_map[name_key] = table_name

    return table_name_map

def normalize_sql(sql: str, valid_table_names: list[str]) -> str:
    sql = sql.replace("\"", "'")

    expression_tree = parse_one(sql, read=Dialects.SQLITE)

    expression_tree = expression_tree.transform(_alias_transformer, valid_table_names)
    expression_tree = expression_tree.transform(_table_transformer, _get_name_map(valid_table_names))
    expression_tree = expression_tree.transform(_group_by_transformer)

    sql = expression_tree.sql(dialect=Dialects.MYSQL, identify=True)

    sql = _join_transformer(sql)

    return sql
