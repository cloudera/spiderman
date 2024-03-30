import os
from alive_progress import alive_bar;

from utils.zip import ZipReader
from utils.print import print_dict
from core.extractors import extract_db
from core.dataset import get_stats
import core.paths as paths


print("Extracting SCHEMA and DATA of databases.")
print("Note: QUERIES would not be rebuild from original source as they have \
been heavily modified to work with non sqlite databases.\n")

with ZipReader(paths.SOURCE_ZIP) as sourceZip:
    files = sourceZip.list_sqlite_files_in(paths.SOURCE_DB_DIR)
    with alive_bar(len(files)) as bar:
        for file in files:
            db_name = file.name
            db_data = sourceZip.read_file(file.path)
            extract_db(db_name, db_data)
            bar()

print("DB extraction completed successfully.")
print_dict(get_stats(), label="--- Dataset Stats ---")
