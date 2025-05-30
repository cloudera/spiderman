"""Load schema and data into a target database"""

from core import paths
from core.target_db import TargetDB
from core.dataset import DatasetDir
from utils.iter import bar_iter
from utils.filesystem import read_json_dict
from utils.args import parse_url_dialect


def create_databases(dataset: DatasetDir):
    """Creating databases"""

    print("Creating databases...")
    for db_name, _ in bar_iter(dataset.get_db_names(), "DB"):
        with TargetDB(args.url, db_name, reset=True) as db:
            schema_ddls = dataset.read_schema(db_name)
            db.execute_statements(schema_ddls)


def insert_data(dataset: DatasetDir):
    """Inserting data"""

    # Get list of table names, ordered based on foreign key dependency
    ordered_tables = read_json_dict(paths.ORDERED_TABLES)

    print("Inserting data...")
    for db_name, bar in bar_iter(dataset.get_db_names(), "DB"):
        with TargetDB(args.url, db_name) as db:
            table_names = ordered_tables[db_name]
            for table_name in table_names:
                bar.text(f">> DB: {db_name} | Table: {table_name}")
                df = dataset.read_table_data(db_name, table_name)
                bar.text(f">> DB: {db_name} | Table: {table_name} | Rows: {len(df.values)}")
                db.insert(table_name, list(df.columns), list(df.values))


if __name__ == "__main__":
    args = parse_url_dialect("Load dataset into a target database")
    dataset = DatasetDir(args.dialect)

    print(f"Loading dataset from {dataset.base_path} directory.")
    create_databases(dataset)
    insert_data(dataset)
    print("Load successful.")
