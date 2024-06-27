import argparse
from alive_progress import alive_bar;

import core.paths as paths
from core.target_db import TargetDB
from core.dataset import get_db_names, get_data, path_to_schema_file
from utils.filesystem import read_str, read_json_dict


parser = argparse.ArgumentParser(description=f"SpiderMan - Load schema and data into a target database")
parser.add_argument("url", help="SQLAlchemy friendly URL to the target database")
args = parser.parse_args()

# Get list of table names, ordered based on foreign key dependency
ordered_tables = read_json_dict(paths.ORDERED_TABLES)

db_names = get_db_names()

# --- Creating databases --------------------------------------------
print("Creating databases...")

with alive_bar(len(db_names)) as bar:
    for db_name in db_names:
        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name, reset=True) as db:
            file_path = path_to_schema_file(db_name)
            schema = read_str(file_path)
            db.execute(schema)
        bar()

# --- Inserting data ------------------------------------------------
print("Inserting data...")

with alive_bar(len(db_names)) as bar:
    for db_name in db_names:
        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name) as db:
            table_names = ordered_tables[db_name]
            for table_name in table_names:
                bar.text(f">> DB: {db_name} | Table: {table_name}")
                column_names, rows = get_data(db_name, table_name)

                bar.text(f">> DB: {db_name} | Table: {table_name} | Rows: {len(rows)}")
                db.insert(table_name, column_names, rows)
        bar()
