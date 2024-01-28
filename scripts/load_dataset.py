import sys

from alive_progress import alive_bar;

from core.target_db import TargetDB
from core.dataset import get_all_schema_statements

url = sys.argv[1] if len(sys.argv) > 1 else None
dataset_dir = sys.argv[2] if len(sys.argv) > 2 else "/opt/hive/data/warehouse/spiderman"

if not url or not dataset_dir:
    print("""SpiderMan - load_dataset
Usage: python scripts/load_dataset.py <url> <dataset_dir>

Eg URL: hive://<address>:10000""")
    exit(1)

stmts = get_all_schema_statements()

with alive_bar(len(stmts)) as bar:
    with TargetDB(f"{url}/default") as db:
        for stmt in stmts:
            stmt = stmt.replace("${DATASET_DIR}", dataset_dir)
            db.execute(stmt)
            bar()
