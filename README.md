# SpiderMan
A dataset for Hive dialect.

## Setup
### Install OS Dependencies
#### CentOS
```
yum install python-pip gcc gcc-c++ python-virtualenv cyrus-sasl-devel
```

### Setup Conda
```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
```
### Setup Environment
```
conda create --name spiderman-env python=3.9.16
conda activate spiderman-env
pip install -r requirements.txt
```

# Load schema & data
```
python scripts/create_schema.py 'hive://<hive-address>:10000'
python scripts/insert_data.py 'hive://<hive-address>:10000'
```

# Scan Dataset
```
python scripts/scan_dataset.py
```
