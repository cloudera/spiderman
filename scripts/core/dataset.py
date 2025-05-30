import os
from os import path
from enum import Enum
import pandas as pd

import shutil

from utils.filesystem import write_str, read_str, write_csv


TABLE_DELIM = "\n\n"

class QuerySplit(str, Enum):
    TRAIN = "train"
    TEST = "test"

class DatasetDir:
    dialect: str

    base_path: str
    dbs_path: str
    data_path: str

    def __init__(self, dialect: str, suffix:str = "") -> None:

        self.dialect = dialect.lower()

        if suffix:
            self.base_path = f"./dataset_{self.dialect}_{suffix.lower()}"
        else:
            self.base_path = f"./dataset_{self.dialect}"

        self.dbs_path = path.join(self.base_path, "databases")

    def _path_to_table_data_file(self, db_name: str, table_name) -> str:
        return path.join(self.dbs_path, db_name, 'data', f"{table_name}.csv")

    def _path_to_schema_file(self, db_name: str) -> str:
        return path.join(self.dbs_path, db_name, 'schema.sql')

    def _path_to_queries_file(self, split: QuerySplit) -> str:
        return path.join(self.base_path, f'{split.value}_queries.csv')

    def get_db_names(self) -> list[str]:
        db_names = os.listdir(self.dbs_path)

        # Remove any hidden files or directories
        if '.DS_Store' in db_names:
            db_names.remove('.DS_Store')

        db_names.sort()
        return db_names

    def read_schema(self, db_name: str) -> list[str]:
        schema = read_str(self._path_to_schema_file(db_name))
        return schema.split(TABLE_DELIM)[1:]

    def read_table_data(self, db_name: str, table_name: str) -> pd.DataFrame:
        file_path = path.join(self.dbs_path, db_name, 'data', f"{table_name}.csv")
        return pd.read_csv(file_path, dtype=str, na_filter=False)

    def read_queries(self, split: QuerySplit) -> pd.DataFrame:
        file_path = self._path_to_queries_file(split)
        return pd.read_csv(file_path, dtype=str, na_filter=False)

    def write_schema(self, db_name: str, table_ddls: list[str]) -> None:
        """Write schema of a database to a file"""
        schema_arr = [
            f"-- Dialect: {self.dialect} | Database: {db_name} | Table Count: {len(table_ddls)}",
        ]
        schema_arr = schema_arr + table_ddls

        if len(schema_arr):
            schema = TABLE_DELIM.join(schema_arr)
            schema = schema + "\n" # New line at EOF
            write_str(self._path_to_schema_file(db_name), schema)

    def write_table_data(self, db_name: str, table_name: str, data: list[list]) -> None:
        """Write table data to a CSV file"""
        file_path = self._path_to_table_data_file(db_name, table_name)
        write_csv(file_path, data)

    def write_queries(self, split: QuerySplit, queries: list):
        data = [["database", "question", "sql"]] + queries
        write_csv(self._path_to_queries_file(split), data)

    def delete(self):
        if path.exists(self.base_path):
            print(f"Deleting dataset {self.base_path}")
            shutil.rmtree(self.dbs_path)
            os.remove(self._path_to_queries_file(QuerySplit.TRAIN))
            os.remove(self._path_to_queries_file(QuerySplit.TEST))
