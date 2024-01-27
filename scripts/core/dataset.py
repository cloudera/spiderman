import os
from os import path


BASE_DIR = './dataset'

def path_to_data_dir(db_name: str) -> str:
    return path.join(BASE_DIR, db_name, 'data')

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

def get_db_names() -> list[str]:
    db_names = os.listdir(BASE_DIR)
    return _clean_names(db_names)

def get_queries(db_name: str) -> str:
    file_path = path_to_train_queries_file(db_name)
    if not path.isfile(file_path):
        file_path = path_to_test_queries_file(db_name)

    with open(file_path) as f:
        return f.read()

def get_schema(db_name: str) -> str:
    with open(path_to_schema_file(db_name)) as f:
        return f.read()


def get_all_schema_statements() -> list[str]:
    statements = []
    db_names = get_db_names()
    for db_name in db_names:
        db_schema = get_schema(db_name)
        db_stmts = db_schema.split(";")
        for stmt in db_stmts:
            stmt = stmt.strip()
            if stmt: statements.append(stmt)

    return statements

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
        total_queries += queries.count('\n')


    print("\n--- Dataset Stats ---")
    print("DBs in source: ", len(db_names))
    print("DBs with training queries: ", dbs_with_train_queries)
    print("DBs with test queries: ", dbs_with_test_queries)

    print("DBs with data: ", dbs_with_data)
    print("Total tables: ", total_tables)
    print("Total queries: ", total_queries)
    print("")
