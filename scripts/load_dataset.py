"""Load schema and data into a target database"""

import pandas as pd
from alive_progress import alive_bar

from core import paths
from core.target_db import TargetDB
from core.dataset import DatasetDir
from utils.filesystem import read_str, read_json_dict
from utils.args import get_args


args = get_args("Load schema and data into a target database")

# Get list of table names, ordered based on foreign key dependency
ordered_tables = read_json_dict(paths.ORDERED_TABLES)

dataset = DatasetDir(args.dialect)
db_names = dataset.get_db_names()

def create_databases():
    """Creating databases"""

    print("Creating databases...")
    with alive_bar(len(db_names)) as progress:
        for db_name in db_names:
            progress.text(f">> DB: {db_name}")
            with TargetDB(args.url, db_name, reset=True) as db:
                file_path = dataset.path_to_schema_file(db_name)
                schema = read_str(file_path)
                db.execute(schema)
            progress() # pylint: disable=not-callable

def insert_data():
    """Inserting data"""

    print("Inserting data...")
    with alive_bar(len(db_names)) as progress:
        for db_name in db_names:
            progress.text(f">> DB: {db_name}")
            with TargetDB(args.url, db_name) as db:
                table_names = ordered_tables[db_name]
                for table_name in table_names:
                    progress.text(f">> DB: {db_name} | Table: {table_name}")
                    table_data_file = dataset.path_to_table_data_file(db_name, table_name)
                    df = pd.read_csv(table_data_file, dtype=str, na_filter=False)
                    progress.text(f">> DB: {db_name} | Table: {table_name} | Rows: {len(df.values)}")
                    db.insert(table_name, df.columns, df.values)
            progress() # pylint: disable=not-callable

create_databases()
insert_data()
print("Load successful.")
