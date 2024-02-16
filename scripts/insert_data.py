from alive_progress import alive_bar;

from core.target_db import TargetDB
from core.dataset import get_db_names, get_table_names, get_data

from utils.args import get_args


args = get_args(description="Insert data into databases")
print("Inserting data...")

skip_dbs = args.skip_dbs or ["baseball_1", "soccer_1", "wta_1"] # Skipping by default as they are very large
db_names = get_db_names(skip_dbs)

with alive_bar(len(db_names)) as bar:
    for db_name in db_names:
        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name) as db:
            table_names = get_table_names(db_name)
            for table_name in table_names:
                bar.text(f">> DB: {db_name} | Table: {table_name}")
                column_names, rows = get_data(db_name, table_name)

                bar.text(f">> DB: {db_name} | Table: {table_name} | Rows: {len(rows)}")
                db.insert(table_name, column_names, rows)
        bar()
