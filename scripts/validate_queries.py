"""
Try running train & test queries on the target database,
and validate they can be successfully executed
"""

import sys

import pandas as pd

from core.target_db import TargetDB
from core.dataset import DatasetDir, QuerySplit
from utils.iter import bar_iter
from utils.args import parse_url_dialect


def execute_queries(queries_df: pd.DataFrame):
    """Execute all queries from file at query_file_path"""

    db_names = sorted(set(queries_df['database']))

    for db_name, bar in bar_iter(db_names, "DB"):
        db_queries_df = queries_df[queries_df['database'] == db_name].reset_index(drop=True)
        query_count = len(db_queries_df)

        with TargetDB(args.url, db_name) as db:
            for idx, query in db_queries_df.iterrows():
                try:
                    bar.text(f">>>> DB: {db_name} | Query: {idx}/{query_count}")
                    db.execute_statements([query["sql"]])
                except Exception as e:
                    print(e)
                    print("Details: ", db_name, idx, query["question"], query["sql"])
                    sys.exit()

    print(f"Executed {len(queries_df)} queries.")


if __name__ == "__main__":
    args = parse_url_dialect("Validate successful execution of all queries on the target database")
    dataset = DatasetDir(args.dialect)

    print("Executing train queries...")
    execute_queries(dataset.read_queries(QuerySplit.TRAIN))

    print("Executing test queries...")
    execute_queries(dataset.read_queries(QuerySplit.TEST))

    print("Validation successful.")
