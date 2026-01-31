from argparse import ArgumentParser
from datetime import datetime
import os
from typing import NamedTuple
from urllib.parse import urljoin

from pandas import Series
import requests
from core.dataset import DatasetDir, QuerySplit
from scripts.utils.iter import bar_iter
from utils.args import dialect_parser, test_split_parser


class SQLAIRunner:
    def __init__(self, dialect: str, base_url: str, model_details: str):
        self.dialect = dialect
        self.base_url = base_url
        self.model_details = model_details

        self.cdp_access_token = os.getenv("CDP_ACCESS_TOKEN")
        if not self.cdp_access_token:
            raise ValueError("CDP_ACCESS_TOKEN environment variable is not set")

    def post_request(self, path: str, payload: dict) -> dict:
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.cdp_access_token}"
        }
        response = requests.post(urljoin(self.base_url, path), json=payload, headers=headers)
        return response.json()

    def run_query(self, query: NamedTuple) -> str:
        payload = {
            "task": "generate",
            "dialect": self.dialect,
            "object_selectors": [query.database],
            "input": query.question
        }

        response = self.post_request("/api/v1/ai/assistant", payload)
        if 'error' in response:
            raise ValueError(response.get('error', 'Post request on /api/v1/ai/assistant returned unknown error'))

        return response['response']['sql']

    def run(self, dataset_dir: DatasetDir, split: QuerySplit, limit: int = None) -> None:
        queries_df = dataset_dir.read_queries(split)

        if limit:
            queries_df = queries_df.head(limit)

        sql_data: list[str] = []
        queries = list(queries_df.itertuples(index=False))
        for row, _bar in bar_iter(queries):
            sql = self.run_query(row)
            sql_data.append(sql)

        configs = self.post_request("/api/v1/get_config", {})

        # Dialect and split are already in file level sql_results metadata
        metadata = {
            'service_name': configs['hue_config']['ai_service_name'],
            'model_details': self.model_details,
            'timestamp': datetime.now().isoformat(),
        }
        dataset_dir.write_sql_results(split, queries_df, metadata, sql_data)


if __name__ == "__main__":
    parser = ArgumentParser(
        description="SpiderMan - Run SQL AI tasks with queries from the dataset of a specific dialect and split",
        parents=[dialect_parser, test_split_parser]
    )
    parser.add_argument("base_url", help="Base URL at which SQL AI service is running.")
    parser.add_argument("model_details", help=(
        "Short description of the model used. Include model name, version, parameters size, "
        "and any other relevant details. Useful at the time of report generation."
    ))
    parser.add_argument(
        "-l", "--limit",
        help="Limit the number of queries to run. Defaults to all queries.",
        default=None,
        type=int
    )
    args = parser.parse_args()

    dataset_dir = DatasetDir(args.dialect)
    split = QuerySplit(args.split)

    print(f"Running SQL AI tasks with {split.value} queries from {dataset_dir.base_path} directory")
    runner = SQLAIRunner(args.dialect, args.base_url, args.model_details)
    runner.run(dataset_dir, split, args.limit)
    print("SQL AI run completed successfully.")
