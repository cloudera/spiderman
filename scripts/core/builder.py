from typing import Dict

from core.dataset import DatasetDir, QuerySplit

import core.mysql_builder as mysql
from core import paths
from core.source_db import SourceDB
from utils.filesystem import read_json_dict


DIALECT = "MySQL"
TABLE_DELIM = "\n\n"

# List of table names, ordered based on foreign key dependency
ordered_tables = read_json_dict(paths.ORDERED_TABLES)

# Details of modifications to be made on the data
data_overrides = read_json_dict(paths.DATA_OVERRIDES)
# Delete rows with invalid foreign key values or datatypes
delete_filters = data_overrides["delete_filters"]
add_data = data_overrides["add"]

# Detail of transformations to be made on the query
query_overrides = read_json_dict(paths.QUERY_OVERRIDES)
full_replace = query_overrides["full_replace"]
skipped_questions = query_overrides["skip"]


def _filter_data(table_data: list[list], delete_filters: dict) -> list[list]:
    column_names: list = table_data[0]
    rows: list[list] = table_data[1:]

    for col_name, filtered_values in delete_filters.items():
        col_index = column_names.index(col_name)
        rows = list(filter(lambda row: row[col_index] not in filtered_values, rows))

    return [column_names] + rows

# Get data of each table in the given list. Return false if any is missing.
# Write to a CSV file if all are available and return true.
def _build_data(dataset: DatasetDir, table_names: list[str], db: SourceDB) -> bool:
    table_data_map: Dict[str, list] = {}

    # Get data
    for table_name in table_names:
        table_data = table_data_map[table_name] = db.get_table_data(table_name)

        if len(table_data) <= 1:
            # 1st row is always header. Data is missing if <= 1
            print(f"Skipping DB `{db.name}` - Data not available for table `{table_name}`.")
            return False

    # Write data
    for table_name in table_names:
        table_data = table_data_map[table_name]

        # Filter out rows with invalid data
        table_path = f"{db.name}.{table_name}"
        if table_path in delete_filters:
            table_data = _filter_data(table_data, delete_filters[table_path])

        # Add missing data
        if table_path in add_data:
            table_data = table_data + add_data[table_path]

        # Normalize data
        table = db.get_table(table_name)
        table_data = mysql.normalize_data(table_data, table)

        # Write to CSV file
        dataset.write_table_data(db.name, table_name, table_data)

    return True

# Build schema and data of a database if data is available
def build_db(dataset: DatasetDir, db_name: str, data: bytes):
    with SourceDB(db_name, data) as db:
        table_names: list[str] = ordered_tables[db_name]

        all_data_available = _build_data(dataset, table_names, db)
        if all_data_available:
            table_ddls = []

            # Build schema
            for table_name in table_names:
                table = db.get_table(table_name)
                table_ddls.append(mysql.build_table_ddl(table))

            dataset.write_schema(db.name, table_ddls)


def _dedupe_queries(queries: list) -> list:
    deduped_queries: list = []
    query_set = set()

    for query in queries:
        db_name = query["db_id"]
        question = query["question"]
        sql = query["query"]

        key = f"{db_name}|{question}|{sql}"
        if key not in query_set:
            query_set.add(key)
            deduped_queries.append(query)

    return deduped_queries

def build_queries(dataset: DatasetDir, queries: list, split: QuerySplit) -> None:
    db_queries: dict[str, list[list]] = {}

    queries = _dedupe_queries(queries)

    for query in queries:
        db_name = query["db_id"]
        question = query["question"]
        sql = query["query"]

        if question in skipped_questions.get(db_name, []):
            continue

        sql = full_replace.get(db_name, {}).get(question, sql)

        valid_table_names: list[str] = ordered_tables[db_name]
        sql = mysql.normalize_sql(sql, valid_table_names)

        if db_name not in db_queries:
            db_queries[db_name] = []

        db_queries[db_name].append([db_name, question, sql])

    db_names = dataset.get_db_names()
    queries = []
    for db_name in db_names:
        queries = queries + db_queries.get(db_name, [])

    dataset.write_queries(split, queries)
