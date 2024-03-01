# SpiderMan
A comprehensive human-annotated dataset for SQL AI tasks across diverse domains and complexity levels.

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

# Citation

If you find this to be useful, please consider citing:
```
@inproceedings{SpiderMan,
  title  = {SpiderMan: A Comprehensive Human-Annotated Dataset for SQL AI Tasks Across Diverse Domains and Complexity Levels},
  author = {Sreenath Somarajapuram},
  year   = 2024
}
```
SpiderMan is a refined version of the [Spider dataset](https://yale-lily.github.io/spider).
```
@inproceedings{Yu&al.18c,
  title     = {Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task},
  author    = {Tao Yu and Rui Zhang and Kai Yang and Michihiro Yasunaga and Dongxu Wang and Zifan Li and James Ma and Irene Li and Qingning Yao and Shanelle Roman and Zilin Zhang and Dragomir Radev}
  booktitle = "Proceedings of the 2018 Conference on Empirical Methods in Natural Language Processing",
  address   = "Brussels, Belgium",
  publisher = "Association for Computational Linguistics",
  year      = 2018
}
```

# License

[CC BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/legalcode)
