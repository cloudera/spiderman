"""Recreate dataset from source zip into `./dataset_build` directory. Current directory will be deleted and recreated."""

import json

from utils.zip import ZipReader
from utils.iter import bar_iter

from core.builders import build_db, build_queries
from core.dataset import DatasetDir, QuerySplit
from core import paths
from scan_dataset import print_stats


def build_schema_and_data(source_zip: ZipReader, dataset: DatasetDir):
    """Build SCHEMA and DATA of databases"""
    files = source_zip.list_sqlite_files_in(paths.SOURCE_DB_DIR)

    print(f"Building SCHEMA and DATA of {len(files)} databases")
    for file, _ in bar_iter(files, "From file"):
        db_name = file.name
        db_data = source_zip.read_file(file.path)
        build_db(dataset, db_name, db_data)


def build_train_and_test_queries(source_zip: ZipReader, dataset: DatasetDir):
    """Build train and test queries"""

    print("Building train queries...")
    train_queries = json.loads(source_zip.read_file(paths.TRAIN_QUERIES_1))
    train_queries += json.loads(source_zip.read_file(paths.TRAIN_QUERIES_2))
    build_queries(dataset, train_queries, QuerySplit.TRAIN)

    print("Building test queries...")
    test_queries = json.loads(source_zip.read_file(paths.TEST_QUERIES))
    build_queries(dataset, test_queries, QuerySplit.TEST)


if __name__ == "__main__":
    dataset = DatasetDir("mysql", "rebuild")

    print(f"Rebuilding dataset into {dataset.base_path} directory...")
    dataset.delete()
    with ZipReader(paths.SOURCE_ZIP) as source_zip:
        build_schema_and_data(source_zip, dataset)
        build_train_and_test_queries(source_zip, dataset)
    print("Dataset rebuild completed successfully.")

    print_stats(dataset)
