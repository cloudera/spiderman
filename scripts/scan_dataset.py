"""Scan dataset_mysql directory"""

from core.dataset import DatasetDir, QuerySplit
from utils.print import print_bar
from utils.args import parse_dialect


def _get_counts(dataset: DatasetDir, split: QuerySplit) -> tuple[int, int, list[str]]:
    """Get counts of queries, tables and databases for a given split"""

    queries_df = dataset.read_queries(split)
    db_names = sorted(set(queries_df['database']))

    tables_count = 0
    for db_name in db_names:
        tables_count += len(dataset.read_schema(db_name))

    return len(queries_df.values), tables_count, db_names


def print_stats(dataset: DatasetDir) -> None:
    """Get dataset stats and print"""

    train_queries, train_tables, train_db_names = _get_counts(dataset, QuerySplit.TRAIN)
    test_queries, test_tables, test_db_names = _get_counts(dataset, QuerySplit.TEST)

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
    args = parse_dialect("Scan dataset directory of a specific dialect", "mysql")

    dataset_dir = DatasetDir(args.dialect)
    print(f"Scanning {dataset_dir.base_path} directory")
    print_stats(dataset_dir)
