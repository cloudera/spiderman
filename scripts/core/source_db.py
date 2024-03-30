from tempfile import NamedTemporaryFile, _TemporaryFileWrapper
from sqlite3 import connect, Connection

from utils.filesystem import read_json_dict
import core.paths as paths
from pydantic import BaseModel
from typing import List, Union


column_overrides = read_json_dict(paths.COLUMN_OVERRIDES)
datatype_overrides = column_overrides["datatype"]
primary_key_overrides = column_overrides["primary_key"]
unique_overrides = column_overrides["unique"]
foreign_key_overrides = column_overrides["foreign_key"]
index_overrides = column_overrides["index"]


class Column(BaseModel):
    name: str
    type: str
    default_val: Union[str, None]
    is_not_null: bool
    is_primary_key: bool
    is_unique: bool
    is_indexed: bool

class FKConstraint(BaseModel):
    from_columns: List[str]
    to_table: str
    to_columns: List[str]

class Table(BaseModel):
    db_name: str
    name: str
    columns: List[Column]
    foreign_keys: List[FKConstraint]


# Wrapper over a SQLLite file
class SourceDB:
    name: str
    data: bytes
    file: _TemporaryFileWrapper
    connection: Connection

    def __init__(self, name: str, data: bytes):
        self.name = name
        self.data = data

    def __enter__(self):
        self.file = NamedTemporaryFile(suffix=".sqlite")
        self.file.write(self.data)
        self.file.seek(0)

        self.connection = connect(self.file.name, check_same_thread=False)
        self.connection.text_factory = lambda b: b.decode(errors = 'ignore')

        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.connection.close()
        self.file.close()

    def list_tables(self) -> list[str]:
        cursor = self.connection.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        cursor.close()
        return [t[0] for t in tables if t[0] != 'sqlite_sequence']

    def _execute_pragma(self, command: str, table_name: str):
        cursor = self.connection.cursor()
        cursor.execute(f"PRAGMA {command}({table_name})")
        data = cursor.fetchall()
        cursor.close()
        return data

    def _get_unique_column_names(self, table_name: str) -> set[str]:
        indexes = self._execute_pragma('index_list', table_name)

        table_path = f"{self.name}.{table_name}"
        unique_columns = set(unique_overrides[table_path]) if table_path in unique_overrides else set()
        if indexes:
            for index in indexes:
                index_name = index[1]
                use_unique = index[2] == 1 and index[3] == 'u'
                # At index 2 - 1 = Unique, 0 = Not Unique
                # At index 3 - "u" indicates a unique index, and "c" indicates a unique index created to enforce a column constraint.
                # Note: Some unique constraints in cre_Drama_Workshop_Groups & cre_Theme_park would be dropped as they are primary keys
                if use_unique:
                    info = self._execute_pragma('index_info', index_name)[0]
                    unique_columns.add(info[2])

        return unique_columns

    def _get_indexed_column_names(self, table_name: str) -> set[str]:
        indexes = self._execute_pragma('index_list', table_name)

        table_path = f"{self.name}.{table_name}"
        indexed_columns = set(index_overrides[table_path]) if table_path in index_overrides else set()

        for index in indexes:
            if index[3] == 'c': # Index created by CREATE INDEX statement
                index_name = index[1]
                index_info = self._execute_pragma('index_info', index_name)
                indexed_columns.add(index_info[0][2])

        return indexed_columns

    def _get_columns(self, table_name: str) -> List[Column]:
        columns_info = self._execute_pragma('table_info', table_name)
        columns: List[Column] = []

        unique_columns = self._get_unique_column_names(table_name)
        indexed_columns = self._get_indexed_column_names(table_name)

        table_path = f"{self.name}.{table_name}"
        pk_columns = set(primary_key_overrides[table_path]) if table_path in primary_key_overrides else set()

        for col in columns_info:
            col_name = col[1]
            col_type = col[2]

            # For all tables using *
            col_path = f"{self.name}.*.{col_name}"
            if col_path in datatype_overrides:
                col_type = datatype_overrides[col_path]

            # For specific tables
            col_path = f"{self.name}.{table_name}.{col_name}"
            if col_path in datatype_overrides:
                col_type = datatype_overrides[col_path]

            columns.append(Column(
                name = col_name,
                type = col_type,
                is_not_null = col[3],
                default_val = col[4],
                is_primary_key = (col[5] != 0 or col_name in pk_columns),
                is_unique = (col_name in unique_columns),
                is_indexed = (col_name in indexed_columns)
            ))

        return columns

    def _get_foreign_keys(self, table_name: str) -> List[FKConstraint]:
        foreign_keys = self._execute_pragma('foreign_key_list', table_name)

        fk_composite = []
        # Aggregate composite foreign keys
        for fk in foreign_keys:
            seq = fk[1]
            from_column = fk[3]
            to_table = fk[2]
            to_column = fk[4]

            path = f"{self.name}.{table_name}.{from_column}:table"
            if path in foreign_key_overrides:
                to_table = foreign_key_overrides[path]

            path = f"{self.name}.{table_name}.{from_column}:column"
            if path in foreign_key_overrides:
                to_column = foreign_key_overrides[path]

            if fk[1] == 0:
                fk_composite.append(([from_column], to_table, [to_column]))
            else:
                # Composite foreign key columns are given as separate list items by pragma.
                # They must be merged, and following assert ensure that we are not making any invalid merges
                assert seq == len(fk_composite[-1][0]), "Invalid foreign key sequence"
                assert to_table == fk_composite[-1][1], "Invalid foreign key to_table"
                fk_composite[-1][0].append(from_column)
                fk_composite[-1][2].append(to_column)

        foreign_keys = []
        # Build foreign keys constraint
        for fk in fk_composite:
            foreign_keys.append(FKConstraint(
                from_columns=fk[0],
                to_table=fk[1],
                to_columns=fk[2]
            ))

        return foreign_keys

    def get_table(self, table_name: str) -> Table:
        columns = self._get_columns(table_name)
        foreign_keys = self._get_foreign_keys(table_name)

        return Table(
            db_name=self.name,
            name=table_name,
            columns=columns,
            foreign_keys=foreign_keys
        )

    def get_original_table_ddl(self, name: str) -> str:
        cursor = self.connection.cursor()
        cursor.execute(f'SELECT sql FROM sqlite_master WHERE type="table" AND name="{name}"')
        ddl_str = cursor.fetchone()[0]
        cursor.close()
        return ddl_str

    def get_table_data(self, name: str, add_header: bool = True) -> list:
        data = []
        cursor = self.connection.cursor()
        cursor.execute(f"SELECT * FROM {name};")

        if add_header:
            data.append([description[0] for description in cursor.description])

        rows = cursor.fetchall()
        for row in rows:
            decoded_row = tuple(cell.decode('utf-8', errors='replace') if isinstance(cell, bytes) else cell for cell in row)
            data.append(list(decoded_row))

        return data
