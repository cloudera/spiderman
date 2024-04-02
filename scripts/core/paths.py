SOURCE_DIR = "./source"

# --- Spider Zip ----------------------------------------------------
SOURCE_ZIP = SOURCE_DIR + '/spider_v1.zip'
SOURCE_DB_DIR = 'spider/database'
# Example sqlite db file path: spider/database/academic/academic.sqlite

TRAIN_QUERIES_1 = 'spider/train_spider.json'
TRAIN_QUERIES_2 = 'spider/train_others.json'
TEST_QUERIES = 'spider/dev.json'

# --- Overrides -----------------------------------------------------
ORDERED_TABLES = SOURCE_DIR + '/ordered_tables.json'
COLUMN_OVERRIDES = SOURCE_DIR + '/column_overrides.json'
DATA_OVERRIDES = SOURCE_DIR + '/data_overrides.json'
