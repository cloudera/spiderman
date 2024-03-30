from typing import Callable

from sqlalchemy import create_engine, text
from sqlalchemy_utils import database_exists, create_database, drop_database


def batch(iterable, n=1):
    l = len(iterable)
    for ndx in range(0, l, n):
        yield iterable[ndx:min(ndx + n, l)]

def _format(values: list[str], punctuation: str) -> str:
    punctuated_values = []
    for value in values:
        if value != "NULL":
            value = value.replace(punctuation, f'\\{punctuation}') # Escape
            if not value.startswith(punctuation):
                value = f'{punctuation}{value}{punctuation}'
        punctuated_values.append(value)
    str = ', '.join(punctuated_values)
    return f"({str})"


# Wrapper around SQLAlchemy for interacting with external databases
class TargetDB:
    url: str
    db_name: str
    dialect: str
    reset: bool
    preprocessor: Callable[[str], str]

    def __init__(self, url: str, db_name: str, reset: bool = False):
        self.url = f"{url}/{db_name}"
        self.reset = reset
        self.db_name = db_name

    def __enter__(self):
        if not database_exists(self.url):
            create_database(self.url)
        elif self.reset:
            drop_database(self.url)
            create_database(self.url)

        self.engine = create_engine(self.url)
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        return

    def execute_statements(self, statements: list[str]):
        with self.engine.connect() as conn:
            for stmt in statements:
                conn.execute(text(stmt))
            conn.commit()

    def execute(self, sql: str):
        db_stmts = sql.split(";")
        statements = []
        for stmt in db_stmts:
            stmt = stmt.strip()
            if stmt: statements.append(stmt)

        self.execute_statements(statements)

    def insert(self, table_name: str, column_names: list[str], rows: list, batch_size: int = 500):
        columns_str = _format(column_names, '`')

        insert_statements = []
        for rows_batch in batch(rows, batch_size):
            row_strs = [_format(row, '"') for row in rows_batch]
            insert_statements.append(f"INSERT INTO `{table_name}` {columns_str} VALUES {', '.join(row_strs)}")
            # Going with the above dumb approach as PyHive have issues with multi insert https://github.com/dropbox/PyHive/issues/250

        self.execute_statements(insert_statements)
