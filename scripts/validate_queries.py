"""
Try running train & test queries on the target database,
and validate they can be successfully executed
"""

import sys
from alive_progress import alive_bar

import pandas as pd

from core.target_db import TargetDB
from core.dataset import DatasetDir
from utils.args import get_args


args = get_args("Validate successful execution of all queries on the target database")

dataset = DatasetDir(args.dialect)

def execute_queries(query_file_path: str):
    """Execute all queries from file at query_file_path"""

    queries_df = pd.read_csv(query_file_path)
    db_names = sorted(set(queries_df['database']))

    with alive_bar(len(db_names)) as progress:
        for db_name in db_names:
            db_queries_df = queries_df[queries_df['database'] == db_name]
            query_count = len(db_queries_df)

            progress.text(f">> DB: {db_name}")
            with TargetDB(args.url, db_name) as db:
                for idx, query in db_queries_df.iterrows():
                    try:
                        progress.text(f">>>> DB: {db_name} | Query: {idx}/{query_count}")
                        db.execute(query["sql"])
                    except Exception as e:
                        print(e)
                        print("Details: ", db_name, idx, query["question"], query["sql"])
                        sys.exit()

            progress() # pylint: disable=not-callable

    print(f"Executed {len(queries_df)} queries.")

print("Executing train queries...")
execute_queries(dataset.path_to_train_queries_file())

print("Executing test queries...")
execute_queries(dataset.path_to_test_queries_file())

print("Validation successful.")
