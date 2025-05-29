"""
Try running train & test queries on the target database,
and validate they can be successfully executed
"""

import sys
from argparse import ArgumentParser

import pandas as pd

from core.target_db import TargetDB
from core.dataset import DatasetDir, iter_db_names
from utils.args import parse_url_dialect


def execute_queries(query_file_path: str):
    """Execute all queries from file at query_file_path"""

    queries_df = pd.read_csv(query_file_path)
    db_names = sorted(set(queries_df['database']))

    for db_name, bar in iter_db_names(db_names):
        db_queries_df = queries_df[queries_df['database'] == db_name]
        query_count = len(db_queries_df)

        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name) as db:
            for idx, query in db_queries_df.iterrows():
                try:
                    bar.text(f">>>> DB: {db_name} | Query: {idx}/{query_count}")
                    db.execute(query["sql"])
                except Exception as e:
                    print(e)
                    print("Details: ", db_name, idx, query["question"], query["sql"])
                    sys.exit()

    print(f"Executed {len(queries_df)} queries.")


if __name__ == "__main__":
    args = parse_url_dialect(ArgumentParser("SpiderMan - Validate successful execution of all queries on the target database"))
    dataset = DatasetDir(args.dialect)

    print("Executing train queries...")
    execute_queries(dataset.path_to_train_queries_file())

    print("Executing test queries...")
    execute_queries(dataset.path_to_test_queries_file())

    print("Validation successful.")
