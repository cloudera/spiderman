# Spiderman with Apache Hive

## Install dependencies
Spiderman needs Python 3.10, and the following extra pip dependencies for Hive.
```
yum install -y gcc-c++ cyrus-sasl-devel #Linux only
pip install sasl thrift_sasl pyhive
```

## Transpile
Following command can be used to create a copy of the dataset in hive dialect. Once complete the Hive dataset would be available in `./dataset_hive`.
```
python ./scripts/transpile_dataset.py hive
```

## Load
```
python ./scripts/load_dataset.py 'hive://admin:admin@localhost:10000?auth=CUSTOM'
```
