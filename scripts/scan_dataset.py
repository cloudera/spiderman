"""Scan dataset_mysql directory"""

from argparse import ArgumentParser

import pandas as pd

from core.dataset import DatasetDir
from utils.print import print_bar
from utils.filesystem import read_str


def _get_counts(dataset: DatasetDir, query_file_path: str):
    queries = pd.read_csv(query_file_path).values
    db_names = sorted(set(row[0] for row in queries))

    tables_count = 0
    for db_name in db_names:
        schema = read_str(dataset.path_to_schema_file(db_name))
        tables_count += schema.count('CREATE TABLE')

    return len(queries), tables_count, db_names

def print_stats(dataset: DatasetDir) -> dict:
    """Get dataset stats and print"""

    train_queries, train_tables, train_db_names = _get_counts(dataset,
                                                              dataset.path_to_train_queries_file())
    test_queries, test_tables, test_db_names = _get_counts(dataset,
                                                           dataset.path_to_test_queries_file())

    print_bar("Dataset Stats")

    print("Train queries:", train_queries)
    print("Tables used in train queries:", train_tables)
    print(f"DBs with train queries ({len(train_db_names)}):", ", ".join(train_db_names))

    print("\nTest queries:", test_queries)
    print("Tables used in test queries:", test_tables)
    print(f"DBs with test queries ({len(test_db_names)}):", ", ".join(test_db_names))

    print("\nTotal queries:", train_queries + test_queries)
    print("Total tables:", train_tables + test_tables)
    print("Total DBs:", len(train_db_names) + len(test_db_names))

    print_bar()

if __name__ == "__main__":
    parser = ArgumentParser(description="SpiderMan - Scan dataset_mysql directory")
    parser.add_argument("-d", "--dialect", help="Target dialect.", default="mysql")
    args = parser.parse_args()

    dataset_dir = DatasetDir(args.dialect)
    print(f"Scaning {dataset_dir.base_path} directory")
    print_stats(dataset_dir)
