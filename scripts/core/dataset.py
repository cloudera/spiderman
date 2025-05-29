import os
from os import path

from alive_progress import alive_bar
import shutil


class DatasetDir:
    base_path: str
    dbs_path: str

    def __init__(self, suffix: str = "") -> None:
        self.base_path = "./dataset"

        if suffix:
            self.base_path = f"{self.base_path}_{suffix}"

        self.dbs_path = path.join(self.base_path, "databases")

    def path_to_data_dir(self, db_name: str) -> str:
        return path.join(self.dbs_path, db_name, 'data')

    def path_to_table_data_file(self, db_name: str, table_name) -> str:
        return path.join(self.dbs_path, db_name, 'data', f"{table_name}.csv")

    def path_to_schema_file(self, db_name: str) -> str:
        return path.join(self.dbs_path, db_name, 'schema.sql')

    def path_to_train_queries_file(self) -> str:
        return path.join(self.base_path, 'train_queries.csv')

    def path_to_test_queries_file(self) -> str:
        return path.join(self.base_path, 'test_queries.csv')

    def _clean_names(self, names: list[str]) -> list[str]:
        if '.DS_Store' in names:
            names.remove('.DS_Store')
        return names

    def get_db_names(self) -> list[str]:
        db_names = os.listdir(self.dbs_path)
        db_names = self._clean_names(db_names)
        db_names.sort()
        return db_names

    def delete(self):
        if path.exists(self.base_path):
            print(f"Deleting {self.base_path}")
            shutil.rmtree(self.base_path)


def iter_db_names(db_names: list[str]):
    """Iterate over database names in the dataset directory."""

    if not db_names:
        raise ValueError("No databases found in the dataset directory.")

    with alive_bar(len(db_names)) as bar:
        for db_name in db_names:
            bar.text(f">> DB: {db_name}")
            yield db_name, bar
            bar()
