from alive_progress import alive_bar;

from core.target_db import TargetDB
from core.dataset import get_db_names, path_to_queries_file

from utils.args import get_args
from utils.filesystem import read_csv


args = get_args(description="Validate queries")
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
