"""Recreate dataset from source zip into `./dataset_source` directory. Current directory will be deleted and recreated."""

import json
from alive_progress import alive_bar

from utils.zip import ZipReader
from core.extractors import extract_db, extract_queries
from core.dataset import DatasetDir
from core import paths
from scan_dataset import print_stats

dataset = DatasetDir("source")

def extract_schema_and_data(source_zip: ZipReader):
    """Extract SCHEMA and DATA of databases"""
    files = source_zip.list_sqlite_files_in(paths.SOURCE_DB_DIR)

    print(f"Extracting SCHEMA and DATA of {len(files)} databases")
    with alive_bar(len(files)) as progress:
        for file in files:
            db_name = file.name
            db_data = source_zip.read_file(file.path)
            extract_db(dataset, db_name, db_data)
            progress() # pylint: disable=not-callable

def extract_train_and_test_queries(source_zip: ZipReader):
    """Extract train and test queries"""
    train_queries = json.loads(source_zip.read_file(paths.TRAIN_QUERIES_1))
    train_queries += json.loads(source_zip.read_file(paths.TRAIN_QUERIES_2))
    test_queries = json.loads(source_zip.read_file(paths.TEST_QUERIES))

    print("Extracting train queries...")
    extract_queries(dataset, train_queries, False)

    print("Extracting test queries...")
    extract_queries(dataset, test_queries, True)

def extract_from_zip():
    """Extract from source Zip"""
    with ZipReader(paths.SOURCE_ZIP) as source_zip:
        extract_schema_and_data(source_zip)
        extract_train_and_test_queries(source_zip)

dataset.delete()
extract_from_zip()
print("Dataset rebuild completed successfully.")
print_stats(dataset)
