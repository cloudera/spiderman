from typing import Callable, Optional

from sqlalchemy import text

from . import TargetDB


class HiveTargetDB(TargetDB):
    """Wrapper around SQLAlchemy for interacting with Hive databases"""

    def __init__(self, url: str, db_name: str):
        super().__init__(url, db_name)

    def drop(self):
        """Drop the Hive database"""
        with self.engine.connect() as conn:
            conn.execute(text(f"DROP DATABASE IF EXISTS {self.db_name} CASCADE"))

    def insert(self, db_name: str, table_name: str, column_names: list[str],
               rows: list, batch_size: int = 500, progress_callback: Optional[Callable[[float], None]] = None):
        """Insert data into a Hive table"""
        self.execute_statements([f"LOAD DATA LOCAL INPATH '/mnt/dataset/databases/{db_name}/data/{table_name}.csv' INTO TABLE {table_name}"])
