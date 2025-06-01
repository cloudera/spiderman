# Spiderman with Apache Hive

## Install dependencies
Spiderman needs Python 3.10, and the following extra pip dependencies for Hive.
```
pip install sasl thrift_sasl pyhive
```

## Transpile
Following command can be used to create a copy of the dataset in hive dialect. Once complete the Hive dataset would be available in `./dataset_hive`.
```
python ./scripts/transpile_dataset.py hive
```

## Load
```
python ./scripts/load_dataset.py 'hive://admin:admin@ccycloud-2.nightly7x-us-gk.root.comops.site:10000?auth=CUSTOM'
```
