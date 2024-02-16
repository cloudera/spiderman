from alive_progress import alive_bar;

from core.target_db import TargetDB
from core.dataset import get_db_names, get_schema, get_table_names, get_data

from utils.args import get_args


args = get_args(description="Create schema for databases")
print("Creating databases...")

db_names = get_db_names(args.skip_dbs)

with alive_bar(len(db_names)) as bar:
    for db_name in db_names:
        bar.text(f">> DB: {db_name}")
        with TargetDB(args.url, db_name) as db:
            schema = get_schema(db_name)
            db.execute(schema)
        bar()
