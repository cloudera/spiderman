# spiderman
Spiderman dataset for Hive dialect

## Setup
```
conda create --name spiderman-env python=3.9.16
conda activate spiderman-env
```

# Load
```
rsync -avz -e ssh --ignore-existing dataset/* hue@<address>:/home/hue/mounts/hive-warehouse/spiderman
python scripts/load_dataset.py 'hive://<address>:10000'
```

# Scan Dataset
```
python scripts/scan_dataset.py
```
