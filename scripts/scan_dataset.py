"""Scan dataset_mysql directory"""

from argparse import ArgumentParser

from core.dataset import DatasetDir
from utils.print import print_dict
from utils.filesystem import read_str, read_csv


def _get_counts(dataset: DatasetDir, query_file_path: str):
    queries = read_csv(query_file_path)[1:]

    db_names = list(set(row[0] for row in queries))

    tables_count = 0
    for db_name in db_names:
        schema = read_str(dataset.path_to_schema_file(db_name))
        tables_count += schema.count('CREATE TABLE')

    return len(queries), len(db_names), tables_count

def print_stats(dataset: DatasetDir) -> dict:
    train_queries, train_dbs, train_tables = _get_counts(dataset, dataset.path_to_train_queries_file())
    test_queries, test_dbs, test_tables = _get_counts(dataset, dataset.path_to_test_queries_file())

    db_names = dataset.get_db_names()

    stats = {
        "Train queries": train_queries,
        "Tables used in train queries": train_tables,
        "DBs with train queries": train_dbs,

        "Test queries": test_queries,
        "Tables used in test queries": test_tables,
        "DBs with test queries": test_dbs,

        "Total queries": train_queries + test_queries,
        "Total tables": train_tables + test_tables,
        "Total DBs": train_dbs + test_dbs,

        "DB names": ", ".join(db_names)
    }

    print_dict(stats, label="Dataset Stats")

    #TODO: Get top 10 DBs and tables with maximum rows as part of stats

if __name__ == "__main__":
    parser = ArgumentParser(description="SpiderMan - Scan dataset_mysql directory")
    parser.add_argument("-d", "--dialect", help="Target dialect.", default="mysql")
    args = parser.parse_args()

    dataset_dir = DatasetDir(args.dialect)
    print(f"Scaning {dataset_dir.base_path} directory")
    print_stats(dataset_dir)
