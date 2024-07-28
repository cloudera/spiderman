import os
import shutil
from os import path
from typing import Tuple

from utils.filesystem import read_csv


class DatasetDir:
    path: str

    def __init__(self, suffix: str = "") -> None:
        self.path = "./dataset"

        if suffix:
            self.path = f"{self.path}_{suffix}"

    def path_to_data_dir(self, db_name: str) -> str:
        return path.join(self.path, db_name, 'data')

    def path_to_table_file(self, db_name: str, table_name) -> str:
        return path.join(self.path, db_name, 'data', f"{table_name}.csv")

    def path_to_schema_file(self, db_name: str) -> str:
        return path.join(self.path, db_name, 'schema.sql')

    def path_to_train_queries_file(self, db_name: str) -> str:
        return path.join(self.path, db_name, 'train_queries.csv')

    def path_to_test_queries_file(self, db_name: str) -> str:
        return path.join(self.path, db_name, 'test_queries.csv')

    def path_to_queries_file(self, db_name: str) -> str:
        file_path = self.path_to_train_queries_file(db_name)
        if not path.isfile(file_path):
            file_path = self.path_to_test_queries_file(db_name)

        return file_path

    def _clean_names(self, names: list[str]) -> list[str]:
        if '.DS_Store' in names:
            names.remove('.DS_Store')
        return names

    def get_db_names(self) -> list[str]:
        db_names = os.listdir(self.path)
        db_names = self._clean_names(db_names)
        db_names.sort()
        return db_names

    def get_queries(self, db_name: str) -> list[list]:
        file_path = self.path_to_train_queries_file(db_name)
        if not path.isfile(file_path):
            file_path = self.path_to_test_queries_file(db_name)

        rows = read_csv(file_path)
        return rows[1:]

    def get_data(self, db_name: str, table_name: str) -> Tuple[list, list[list]]:
        table_file = self.path_to_table_file(db_name, table_name)
        rows = read_csv(table_file)
        return rows[0], rows[1:]

    def delete(self):
        if path.exists(self.path):
            print(f"Deleting {self.path}")
            shutil.rmtree(self.path)
