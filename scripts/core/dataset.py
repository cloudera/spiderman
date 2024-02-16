import os
from os import path
from typing import Tuple
import csv

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


def _clean_names(names: list[str]) -> list[str]:
    if '.DS_Store' in names:
        names.remove('.DS_Store')
    return names

def _read_csv(file_path) -> list:
    with open(file_path, mode='r', newline='', encoding='utf-8') as csvfile:
        csv_reader = csv.reader(csvfile)
        return list(csv_reader)


def get_db_names(skip_names: list[str] = []) -> list[str]:
    db_names = os.listdir(BASE_DIR)
    db_names = _clean_names(db_names)
    if skip_names:
        print(f"Skipped DBs ({len(skip_names)}):", *skip_names)
        db_names = [name for name in db_names if name not in skip_names]
    return db_names

def get_table_names(db_name: str) -> list[str]:
    data_dir = path_to_data_dir(db_name)
    table_files = _clean_names(os.listdir(data_dir))
    return [path.splitext(file)[0] for file in table_files]

def get_queries(db_name: str) -> list[list]:
    file_path = path_to_train_queries_file(db_name)
    if not path.isfile(file_path):
        file_path = path_to_test_queries_file(db_name)

    rows = _read_csv(file_path)
    return rows[1:]

def get_schema(db_name: str) -> str:
    with open(path_to_schema_file(db_name)) as f:
        return f.read()

def get_data(db_name: str, table_name: str) -> Tuple[list, list[list]]:
    table_file = path_to_table_file(db_name, table_name)
    rows = _read_csv(table_file)
    return rows[0], rows[1:]

def print_stats():
    dbs_with_data = 0
    total_tables = 0
    total_queries = 0
    dbs_with_train_queries = 0
    dbs_with_test_queries = 0

    db_names = get_db_names()
    for db_name in db_names:
        if path.exists(path_to_data_dir(db_name)):
            dbs_with_data += 1
        else:
            print("No data for DB :", db_name)

        if path.exists(path_to_train_queries_file(db_name)):
            dbs_with_train_queries += 1

        if path.exists(path_to_test_queries_file(db_name)):
            dbs_with_test_queries += 1

        schema = get_schema(db_name)
        total_tables += schema.count('CREATE TABLE')

        queries = get_queries(db_name)
        total_queries += len(queries)


    print("\n--- Dataset Stats ---")
    print("DBs in source: ", len(db_names))
    print("DBs with training queries: ", dbs_with_train_queries)
    print("DBs with test queries: ", dbs_with_test_queries)

    print("DBs with data: ", dbs_with_data)
    print("Total tables: ", total_tables)
    print("Total queries: ", total_queries)
    print("")
