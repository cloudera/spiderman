from typing import List

from core.source_db import Table, Column


INDENTATION = "    "

def _correct_type(col: Column) -> str:
    col_type = col.type.upper()

    if col_type.startswith("NUMBER"):
        col_type = col_type.replace("NUMBER", "NUMERIC")

    if col_type.startswith("VARCHAR2"):
        col_type = col_type.replace("VARCHAR2", "VARCHAR")

    if col_type.startswith("CHARACTER VARCHAR"):
        col_type = col_type.replace("CHARACTER VARCHAR", "VARCHAR")

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
    return f"""DROP TABLE IF EXISTS `{table.db_name}`.`{table.name}`;
CREATE TABLE `{table.db_name}`.`{table.name}` (
{defs_str}
);"""
