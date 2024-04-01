import argparse
import json
from alive_progress import alive_bar

from utils.zip import ZipReader
from utils.print import print_dict
from core.extractors import extract_db, extract_queries
from core.dataset import get_stats
import core.paths as paths


parser = argparse.ArgumentParser(description=f"SpiderMan - Rebuild dataset")
parser.add_argument(
    "-q",
    "--rebuild-queries",
    default=False,
    action=argparse.BooleanOptionalAction,
    help="Rebuild queries along with schema and data. Is disabled by default."
)
args = parser.parse_args()


print("Extracting SCHEMA and DATA of databases.")
with ZipReader(paths.SOURCE_ZIP) as sourceZip:
    files = sourceZip.list_sqlite_files_in(paths.SOURCE_DB_DIR)
    with alive_bar(len(files)) as bar:
        for file in files:
            db_name = file.name
            db_data = sourceZip.read_file(file.path)
            extract_db(db_name, db_data)
            bar()

    if args.rebuild_queries:
        train_queries = json.loads(sourceZip.read_file(paths.TRAIN_QUERIES_1))
        train_queries += json.loads(sourceZip.read_file(paths.TRAIN_QUERIES_2))
        test_queries = json.loads(sourceZip.read_file(paths.TEST_QUERIES))

        extract_queries(train_queries, False)
        extract_queries(test_queries, True)

print("Dataset rebuild completed successfully.")
print_dict(get_stats(), label="Dataset Stats")
