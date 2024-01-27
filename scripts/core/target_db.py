from typing import Callable

from sqlalchemy import create_engine, text
from sqlalchemy_utils import database_exists, create_database


# Wrapper around SQLAlchemy for interacting with external databases
class TargetDB:
    url: str
    dialect: str
    preprocessor: Callable[[str], str]

    def __init__(self, url: str):
        self.url = url

    def __enter__(self):
        if not database_exists(self.url):
            create_database(self.url)

        self.engine = create_engine(self.url)
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        return

    def execute(self, sql: str):
        conn = self.engine.connect()
        conn.execute(text(sql))
        conn.commit()
        conn.close()
