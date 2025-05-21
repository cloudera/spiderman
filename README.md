# SpiderMan
A comprehensive, high-quality, human-annotated plain-text dataset for SQL AI tasks across diverse domains and complexity levels.

## Why SpiderMan
SpiderMan is an improved version of the [Spider 1.0](https://yale-lily.github.io/spider) dataset.

- The databases are made available in plain-text format instead of a set of SQLite files. This makes it easy for you to load the dataset into any database of your choice.
- The schema has been standardized, including the correction of table ordering, column data types, and the enforcement of primary and foreign key constraints.
- Data has been corrected for schema-based validations.
- Queries have been improved for successful execution.

## Dataset
The dataset comprises 157 databases. Each one comes with its respective schema, data, and queries. By default, schema and queries are in MySQL dialect and can be translated to other dialects using the transpiler script. At present, our queries do not extend across multiple databases. Each query within a single database is assigned exclusively to either the training set or the test set, but not to both.

||Queries|Tables|Databases|
|-|-|-|-|
|Train|6726|699|137|
|Test|1034|80|20|
|Total|7760|779|157|

## Setup
The following commands are for macOS.

### Create Environment
```
conda create --name spiderman-env python=3.12.2
conda activate spiderman-env
pip install -r requirements.txt
```

### Start MySQL in Docker
MySQL was chosen as the default dialect because it is one of the most widely used, can be set up quickly, and comes with various validation mechanisms.
```
docker run --name spiderman-mysql -e MYSQL_ROOT_PASSWORD=PeterParker -p 3306:3306 -d mysql:9.0.0
```

## Scripts
### Load Dataset
```
python scripts/load_dataset.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```
It creates schemas for all the databases and populates them with data. It accepts one argument—a SQLAlchemy 2.0 compatible URL to the target database. More details on the URL are available [here](https://docs.sqlalchemy.org/en/20/core/engines.html#database-urls). If the target database is not MySQL, the script will try to transpile the schema and then load.

### Validate Queries
```
python scripts/validate_queries.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```
Once the dataset is loaded, you can run this script to execute the queries. It checks the successful completion of all the queries. Query results are not verified at this point.

### Scan Dataset
```
python scripts/scan_dataset.py
```
This scripts go through the dataset and aggregate various details.

# Citation

If you find this to be useful, please consider citing:
```
@inproceedings{SpiderMan,
 title  = {SpiderMan: A Comprehensive Human-Annotated Dataset for SQL AI Tasks Across Diverse Domains and Complexity Levels},
 author = {Sreenath Somarajapuram and Athira},
 year   = 2024
}

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
- Dataset license : [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode)
- Scripts license : [Apache 2.0](https://apache.org/licenses/LICENSE-2.0.txt)
