# spiderman
Spiderman dataset for Hive dialect

## Setup
```
conda create --name spiderman-env python=3.9.16
conda activate spiderman-env
pip install -r requirements.txt
```

# Load schema & data
```
python scripts/load_dataset.py 'hive://<hive-address>:10000'
```

# Scan Dataset
```
python scripts/scan_dataset.py
```
