"""
Try running train & test queries on the target database,
and ensure they can be successfully executed
"""

from argparse import ArgumentParser
import pandas as pd

from core.dataset import DatasetDir, QuerySplit
from scripts.utils.sha import df_to_sha
from utils.iter import bar_iter
from utils.args import url_dialect_parser
from core.factories import create_target_db


def enrich_queries(queries_df: pd.DataFrame) -> pd.DataFrame:
    """Enrich all queries with result SHAs"""

    db_names = sorted(set(queries_df['database']))
    queries_df = queries_df.copy()

    failure_counter = {}

    for db_name, bar in bar_iter(db_names, "DB"):
        db_queries_df = queries_df[queries_df['database'] == db_name].reset_index(drop=True)
        query_count = len(db_queries_df)

        with create_target_db(args.url, db_name) as db:
            for idx, query in db_queries_df.iterrows():
                try:
                    bar.text(f">>>> DB: {db_name} | Query: {idx}/{query_count}")
                    results = db.execute_statements([str(query["sql"])])
                    if results is not None and len(results) > 0:
                        db_queries_df.loc[idx, 'result_sha'] = df_to_sha(pd.DataFrame(results[1:], columns=results[0]))
                except Exception as e:
                    failure_counter[db_name] = failure_counter.get(db_name, 0) + 1
                    # print(e)
                    # print("Details: ", db_name, idx, query["question"], query["sql"])
                    # sys.exit()

    print(f"Enriched {len(queries_df)} queries.")
    if failure_counter:
        print(f"Failures: {failure_counter}")

    return queries_df

if __name__ == "__main__":
    parser = ArgumentParser(
        description="SpiderMan - Enrich queries",
        parents=[url_dialect_parser]
    )
    args = parser.parse_args()

    dataset = DatasetDir(args.dialect)

    print("Enriching train queries...")
    df = enrich_queries(dataset.read_queries(QuerySplit.TRAIN))
    dataset.write_queries(QuerySplit.TRAIN, df)

    print("Enriching test queries...")
    df = enrich_queries(dataset.read_queries(QuerySplit.TEST))
    dataset.write_queries(QuerySplit.TEST, df)

    print("Enrichment successful.")
