from os import path
from typing import Dict

import core.dataset as dataset
import core.paths as paths
import core.dialects.mysql as mysql
from core.source_db import SourceDB
from utils.filesystem import write_csv, write_str, read_json_dict


TABLE_DELIM = "\n\n"

# Get list of table names, ordered based on foreign key dependency
ordered_tables = read_json_dict(paths.ORDERED_TABLES)

# Human curated details of data to be removed
data_overrides = read_json_dict(paths.DATA_OVERRIDES)
# Delete rows with invalid foreign key values or datatypes
delete_filters = data_overrides["delete_filters"]
add_data = data_overrides["add"]

# Get schema of each table in the given list.
def extract_schema(table_names: list[str], db: SourceDB) -> None:
    schema_ddls = [
        f"-- Dialect: MySQL | Database: {db.name} | Table Count: {len(table_names)}",
        f"CREATE DATABASE IF NOT EXISTS `{db.name}`;"
    ]

    for table_name in table_names:
        table = db.get_table(table_name)
        ddl = mysql.build_table_ddl(table)
        schema_ddls.append(ddl)

    file_path = dataset.path_to_schema_file(db.name)

    if len(schema_ddls):
        schema = TABLE_DELIM.join(schema_ddls)
        schema = schema + "\n" # New line at EOF
        write_str(file_path, schema)

def filter_data(table_data: list[list], delete_filters: dict) -> list[list]:
    column_names: list = table_data[0]
    rows: list[list] = table_data[1:]

    for col_name, filtered_values in delete_filters.items():
        col_index = column_names.index(col_name)
        rows = list(filter(lambda row: row[col_index] not in filtered_values, rows))

    return [column_names] + rows

# Get data of each table in the given list. Return false if any is missing.
# Write to a CSV file if all are available and return true.
def extract_data(table_names: list[str], db: SourceDB) -> bool:
    data_dir = dataset.path_to_data_dir(db.name)

    table_data_map: Dict[str, list] = {}

    # Get data
    for table_name in table_names:
        table_data = table_data_map[table_name] = db.get_table_data(table_name)

        if len(table_data) <= 1:
            # 1st row is always header. Data is missing if <= 1
            print(f"Skipping DB `{db.name}` - Data not available for table `{table_name}`.")
            return True

    # Write data
    for table_name in table_names:
        table_data = table_data_map[table_name]

        # Filter out rows with invalid data
        table_path = f"{db.name}.{table_name}"
        if table_path in delete_filters:
            table_data = filter_data(table_data, delete_filters[table_path])

        # Add missing data
        if table_path in add_data:
            table_data = table_data + add_data[table_path]

        # Normalize data
        table = db.get_table(table_name)
        table_data = mysql.normalize_data(table_data, table)

        file_path = path.join(data_dir, f'{table_name}.csv')
        write_csv(file_path, table_data)

    return False


# Extract schema and data of a database if data is available
def extract_db(db_name: str, data: bytes):
    with SourceDB(db_name, data) as db:
        table_names: list[str] = ordered_tables[db_name]

        data_is_missing = extract_data(table_names, db)
        if not data_is_missing:
            extract_schema(table_names, db)

def extract_queries(queries: list, is_test: bool):
    db_queries: dict[str, list[list]] = {}

    for query in queries:
        db_name = query["db_id"]
        question = query["question"]
        sql = query["query"]

        sql = mysql.normalize_sql(sql)

        if db_name not in db_queries:
            db_queries[db_name] = []

        db_queries[db_name].append([question, sql])

    for db_name in db_queries:
        file_path = dataset.path_to_test_queries_file(db_name) if is_test \
                    else dataset.path_to_train_queries_file(db_name)

        if path.isfile(file_path): # Only rebuild, dont create skipped databases
            data = [["question", "sql"]] + db_queries[db_name]
            write_csv(file_path, data)
