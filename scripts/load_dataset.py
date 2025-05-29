"""Load schema and data into a target database"""

import pandas as pd
from argparse import ArgumentParser


from core import paths
from core.target_db import TargetDB
from core.dataset import DatasetDir, iter_db_names
from utils.filesystem import read_str, read_json_dict
from utils.args import parse_url_dialect


def create_databases(dataset: DatasetDir):
    """Creating databases"""

    print("Creating databases...")
    for db_name, _ in iter_db_names(dataset.get_db_names()):
        with TargetDB(args.url, db_name, reset=True) as db:
            file_path = dataset.path_to_schema_file(db_name)
            schema = read_str(file_path)
            db.execute(schema)


def insert_data(dataset: DatasetDir):
    """Inserting data"""

    # Get list of table names, ordered based on foreign key dependency
    ordered_tables = read_json_dict(paths.ORDERED_TABLES)

    print("Inserting data...")
    for db_name, bar in iter_db_names(dataset.get_db_names()):
        with TargetDB(args.url, db_name) as db:
            table_names = ordered_tables[db_name]
            for table_name in table_names:
                bar.text(f">> DB: {db_name} | Table: {table_name}")
                table_data_file = dataset.path_to_table_data_file(db_name, table_name)
                df = pd.read_csv(table_data_file, dtype=str, na_filter=False)
                bar.text(f">> DB: {db_name} | Table: {table_name} | Rows: {len(df.values)}")
                db.insert(table_name, df.columns, df.values)


if __name__ == "__main__":
    args = parse_url_dialect(ArgumentParser("SpiderMan - Load schema and data into a target database"))
    dataset = DatasetDir(args.dialect)

    create_databases(dataset)
    insert_data(dataset)

    print("Load successful.")
