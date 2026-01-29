# Spiderman with Apache Hive

## Install dependencies
Spiderman needs Python 3.10, and the following extra dependencies for Hive.
```shell
yum install -y gcc-c++ cyrus-sasl-devel #Linux only
uv pip install sasl thrift_sasl pyhive
```

## Transpile
Following command can be used to create a copy of the dataset in hive dialect. Once complete the Hive dataset would be available in `./dataset_hive`.
```shell
uv run ./scripts/transpile_dataset.py hive
```

## Start Hive
After transpiling you can start Hive in docker using the following commands in spiderman repo root. Dataset would be mounted for use at the time of load.
```shell
docker run -d \
  -p 10000:10000 -p 10002:10002 \
  -v spiderman_hive4_warehouse:/opt/hive/data/warehouse \
  -v $PWD/dataset_hive:/mnt/dataset \
  --env SERVICE_NAME=hiveserver2 \
  --name hive4 \
  apache/hive:4.0.0-beta-1
```

## Load
```shell
uv run ./scripts/load_dataset.py 'hive://admin:admin@localhost:10000?auth=CUSTOM'
```
The script automatically detects the dialect from the url, and need not be passed separately. But if needed -d/--dialect argument is available.

## Validate
```shell
uv run scripts/validate_queries.py 'hive://admin:admin@localhost:10000?auth=CUSTOM'
```
The script automatically detects the dialect from the url, and need not be passed separately. But if needed -d/--dialect argument is available.
