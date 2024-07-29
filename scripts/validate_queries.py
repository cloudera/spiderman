"""Try running train & test queries on the target database, and validate they can be successfully executed"""

import sys
from alive_progress import alive_bar

from core.target_db import TargetDB
from core.dataset import DatasetDir
from utils.filesystem import read_csv
from utils.args import get_args


args = get_args("Validate successful execution of all queries on the target database")

dataset = DatasetDir(args.dialect)

def get_db_sql_map(query_file_path: str) -> dict[str, list[str]]:
    db_sql_map: dict[str, list[str]] = {}

    queries = read_csv(query_file_path)[1:]
    for query in queries:
        db_name = query[0]
        sql = query[2]

        if db_name not in db_sql_map:
            db_sql_map[db_name] = []

        db_sql_map[db_name].append(sql)

    return db_sql_map

def execute_sql(db_sql_map: dict[str, list[str]]):
    with alive_bar(len(db_sql_map.keys())) as progress:
        for db_name in db_sql_map:

            progress.text(f">> DB: {db_name}")
            with TargetDB(args.url, db_name) as db:
                sqls = db_sql_map[db_name]

                count = len(sqls)
                for idx, sql in enumerate(sqls):
                    progress.text(f">>>>> DB: {db_name} | {idx} | Query: {idx}/{count}")
                    try:
                        db.execute(sql)
                    except Exception as e:
                        print(e)
                        print("Details: ", db_name, idx, sql)
                        sys.exit()

            progress() # pylint: disable=not-callable

print("Executing train queries...")
execute_sql(get_db_sql_map(dataset.path_to_train_queries_file()))

print("Executing test queries...")
execute_sql(get_db_sql_map(dataset.path_to_test_queries_file()))

print("Validation successful.")
