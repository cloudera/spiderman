"""Load schema and data into a target database"""

from core import paths
from core.dataset import DatasetDir
from core.factories import create_target_db

from utils.iter import bar_iter
from utils.filesystem import read_json_dict
from utils.args import parse_url_dialect

def create_databases(dataset: DatasetDir):
    """Creating databases"""

    print("Creating databases...")
    for db_name, _ in bar_iter(dataset.get_db_names(), "DB"):
        with create_target_db(args.url, db_name) as db:
            db.reset()
            schema_ddls = dataset.read_schema(db_name)
            db.execute_statements(schema_ddls)


def insert_data(dataset: DatasetDir):
    """Inserting data"""

    # Get list of table names, ordered based on foreign key dependency
    ordered_tables = read_json_dict(paths.ORDERED_TABLES)

    print("Inserting data...")
    for db_name, bar in bar_iter(dataset.get_db_names(), "DB"):
        with create_target_db(args.url, db_name) as db:
            table_names = ordered_tables[db_name]
            for table_name in table_names:
                bar.text(f">> DB: {db_name} | Table: {table_name}")
                df = dataset.read_table_data(db_name, table_name)
                total_rows = len(df.values)
                progress_callback = lambda prg: bar.text(f">> DB: {db_name} | Table: {table_name} | Rows: {total_rows} | Progress : {prg:.2%}")
                progress_callback(0.0)
                db.insert(db_name, table_name, list(df.columns), list(df.values), progress_callback=progress_callback)


if __name__ == "__main__":
    args = parse_url_dialect("Load dataset into a target database")
    dataset = DatasetDir(args.dialect)

    print(f"Loading dataset from {dataset.base_path} directory.")
    create_databases(dataset)
    insert_data(dataset)
    print("Load successful.")
