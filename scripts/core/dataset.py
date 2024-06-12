import os
import shutil
from os import path
from typing import Tuple

from utils.filesystem import read_csv, read_str


BASE_DIR = './dataset'

def path_to_data_dir(db_name: str) -> str:
    return path.join(BASE_DIR, db_name, 'data')

def path_to_table_file(db_name: str, table_name) -> str:
    return path.join(BASE_DIR, db_name, 'data', f"{table_name}.csv")

def path_to_schema_file(db_name: str) -> str:
    return path.join(BASE_DIR, db_name, 'schema.sql')

def path_to_train_queries_file(db_name: str) -> str:
    return path.join(BASE_DIR, db_name, 'train_queries.csv')

def path_to_test_queries_file(db_name: str) -> str:
    return path.join(BASE_DIR, db_name, 'test_queries.csv')

def path_to_queries_file(db_name: str) -> str:
    file_path = path_to_train_queries_file(db_name)
    if not path.isfile(file_path):
        file_path = path_to_test_queries_file(db_name)

    return file_path

def _clean_names(names: list[str]) -> list[str]:
    if '.DS_Store' in names:
        names.remove('.DS_Store')
    return names

def get_db_names(skip_list: list[str] = []) -> list[str]:
    db_names = os.listdir(BASE_DIR)
    db_names = _clean_names(db_names)
    if skip_list:
        print(f"Skipped DBs ({len(skip_list)}):", *skip_list)
        db_names = [name for name in db_names if name not in skip_list]
    db_names.sort()
    return db_names

def get_queries(db_name: str) -> list[list]:
    file_path = path_to_train_queries_file(db_name)
    if not path.isfile(file_path):
        file_path = path_to_test_queries_file(db_name)

    rows = read_csv(file_path)
    return rows[1:]

def get_data(db_name: str, table_name: str) -> Tuple[list, list[list]]:
    table_file = path_to_table_file(db_name, table_name)
    rows = read_csv(table_file)
    return rows[0], rows[1:]

def get_stats() -> dict:
    train_queries = 0
    train_tables = 0
    train_dbs = 0

    test_queries = 0
    test_tables = 0
    test_dbs = 0

    db_names = get_db_names()
    for db_name in db_names:
        query_count = len(get_queries(db_name))
        tables_count = read_str(path_to_schema_file(db_name)).count('CREATE TABLE')

        if path.exists(path_to_train_queries_file(db_name)):
            train_queries += query_count
            train_tables += tables_count
            train_dbs += 1

        if path.exists(path_to_test_queries_file(db_name)):
            test_queries += query_count
            test_tables += tables_count
            test_dbs += 1

    return {
        "Train queries": train_queries,
        "Tables used in train queries": train_tables,
        "DBs with train queries": train_dbs,

        "Test queries": test_queries,
        "Tables used in test queries": test_tables,
        "DBs with test queries": test_dbs,

        "Total queries": train_queries + test_queries,
        "Total tables": train_tables + test_tables,
        "Total DBs": len(db_names),
        "DB names": ", ".join(db_names)
    }

    #TODO: Get top 10 DBs and tables with maximum rows as part of stats

def delete_base():
    if path.exists(BASE_DIR):
        print(f"Deleting {BASE_DIR}")
        shutil.rmtree(BASE_DIR)
