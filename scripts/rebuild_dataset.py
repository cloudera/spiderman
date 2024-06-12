import json
from alive_progress import alive_bar

from utils.zip import ZipReader
from utils.print import print_dict
from core.extractors import extract_db, extract_queries
from core.dataset import get_stats, delete_base
import core.paths as paths


delete_base()

def extract_schema_and_data(sourceZip: ZipReader):
    print("Extracting SCHEMA and DATA of databases.")
    files = sourceZip.list_sqlite_files_in(paths.SOURCE_DB_DIR)
    with alive_bar(len(files)) as bar:
        for file in files:
            db_name = file.name
            db_data = sourceZip.read_file(file.path)
            extract_db(db_name, db_data)
            bar()

def extract_train_and_test_queries(sourceZip: ZipReader):
    train_queries = json.loads(sourceZip.read_file(paths.TRAIN_QUERIES_1))
    train_queries += json.loads(sourceZip.read_file(paths.TRAIN_QUERIES_2))
    test_queries = json.loads(sourceZip.read_file(paths.TEST_QUERIES))

    print("Extracting train queries...")
    extract_queries(train_queries, False)

    print("Extracting test queries...")
    extract_queries(test_queries, True)

with ZipReader(paths.SOURCE_ZIP) as sourceZip:
    extract_schema_and_data(sourceZip)
    extract_train_and_test_queries(sourceZip)

    print("Dataset rebuild completed successfully.")
    print_dict(get_stats(), label="Dataset Stats")
