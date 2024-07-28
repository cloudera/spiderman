from os import path

from core.dataset import DatasetDir
from utils.print import print_dict
from utils.filesystem import read_str


def print_stats(dataset: DatasetDir) -> dict:
    train_queries = 0
    train_tables = 0
    train_dbs = 0

    test_queries = 0
    test_tables = 0
    test_dbs = 0

    db_names = dataset.get_db_names()
    for db_name in db_names:
        query_count = len(dataset.get_queries(db_name))
        tables_count = read_str(dataset.path_to_schema_file(db_name)).count('CREATE TABLE')

        if path.exists(dataset.path_to_train_queries_file(db_name)):
            train_queries += query_count
            train_tables += tables_count
            train_dbs += 1

        if path.exists(dataset.path_to_test_queries_file(db_name)):
            test_queries += query_count
            test_tables += tables_count
            test_dbs += 1

    stats = {
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

    print_dict(stats, label="Dataset Stats")

    #TODO: Get top 10 DBs and tables with maximum rows as part of stats

if __name__ == "__main__":
    print_stats(DatasetDir())
