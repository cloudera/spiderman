"""Recreate dataset from source zip into `./dataset_source` directory. Current directory will be deleted and recreated."""

import json
from alive_progress import alive_bar

from utils.zip import ZipReader
from core.builders import build_db, build_queries
from core.dataset import DatasetDir
from core import paths
from scan_dataset import print_stats


DATASET_SUFFIX = "build"
dataset = DatasetDir(DATASET_SUFFIX)

def build_schema_and_data(source_zip: ZipReader):
    """Build SCHEMA and DATA of databases"""
    files = source_zip.list_sqlite_files_in(paths.SOURCE_DB_DIR)

    print(f"Building SCHEMA and DATA of {len(files)} databases")
    with alive_bar(len(files)) as progress:
        for file in files:
            db_name = file.name
            db_data = source_zip.read_file(file.path)
            build_db(dataset, db_name, db_data)
            progress() # pylint: disable=not-callable

def build_train_and_test_queries(source_zip: ZipReader):
    """Build train and test queries"""

    print("Building train queries...")
    train_queries = json.loads(source_zip.read_file(paths.TRAIN_QUERIES_1))
    train_queries += json.loads(source_zip.read_file(paths.TRAIN_QUERIES_2))
    build_queries(dataset, train_queries, dataset.path_to_train_queries_file())

    print("Building test queries...")
    test_queries = json.loads(source_zip.read_file(paths.TEST_QUERIES))
    build_queries(dataset, test_queries, dataset.path_to_test_queries_file())

def build_dataset():
    """Build from source Zip"""
    with ZipReader(paths.SOURCE_ZIP) as source_zip:
        build_schema_and_data(source_zip)
        build_train_and_test_queries(source_zip)

dataset.delete()
build_dataset()
print("Dataset rebuild completed successfully.")
print_stats(dataset)
