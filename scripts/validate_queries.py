import argparse
from alive_progress import alive_bar;

from core.target_db import TargetDB
from core.dataset import get_db_names, path_to_queries_file
from utils.filesystem import read_csv


parser = argparse.ArgumentParser(description=f"SpiderMan - Validate successful execution of all queries on the target database")
parser.add_argument("url", help="SQLAlchemy friendly URL to the target database")
args = parser.parse_args()

print("Executing queries...")

db_names = get_db_names()

with alive_bar(len(db_names)) as bar:
    for db_name in db_names:

        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name) as db:
            queries_file_path = path_to_queries_file(db_name)
            replaced_queries_file_path = queries_file_path[:-3] + "csv"
            queries = read_csv(replaced_queries_file_path)[1:]

            count = len(queries)
            for idx, query in enumerate(queries):
                bar.text(f">>>>> DB: {db_name} | {idx} | Query: {idx}/{count}")
                try:
                    db.execute(query[1])
                except Exception as e:
                    print(e)
                    print("Details: ", db_name, idx, query[0], query[1])
                    exit()

        bar()
