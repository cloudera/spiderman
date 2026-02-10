# SpiderMan
A comprehensive, high-quality, human-annotated plain-text dataset for SQL AI tasks across diverse domains and complexity levels.

## Table of Contents
- [Why SpiderMan](#why-spiderman)
- [Dataset](#dataset)
- [Setup](#setup)
- [Scripts](#scripts)
  - [Run Benchmark](#run-benchmark)
  - [Dataset Scripts](#dataset-scripts)
- [Testing](#testing)
- [Citation](#citation)
- [License](#license)

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
|Train|4663|699|137|
|Test|682|80|20|
|Total|5345|779|157|

## Setup

### Prerequisites

The project needs `uv` to be installed to manage dependencies, and with uv run the following command to install all dependencies. Setting Python version to 3.10 as we use it for development.

```shell
uv sync --python 3.10
```

### Setup Database

We need a database to load the dataset into and run the queries. MySQL was chosen as the default dialect because it is one of the most widely used, can be set up quickly using docker.

```shell
docker run --name spiderman-mysql -e MYSQL_ROOT_PASSWORD=PeterParker -p 3306:3306 -d mysql:9.0.0
```

### Load Dataset
```shell
uv run scripts/load_dataset.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```
It creates schemas for all the databases and populates them with data.

## Scripts

All scripts can be run using `uv run` which automatically manages the virtual environment:

> **Note:** All the URL follows the SQLAlchemy database URL format - `dialect+driver://username:password@host:port/database_name`. More details on the URL are available [here](https://docs.sqlalchemy.org/en/20/core/engines.html#database-urls).

### Run Benchmark

Pre-computed results and benchmarks are included in the repository. However, you can use the following scripts to generate your own results.

#### Run SQL AI Tasks
```shell
uv run scripts/run_sqlai.py mysql http://127.0.0.1:8000 "<Model details>"
```

This script generates SQL queries using a SQL AI service and saves the results to a JSON file for `test` queries of a specific `dialect`. Run with `-h` to see all available options.

#### Generate Report
```shell
uv run scripts/generate_report.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```

This script analyzes the SQL results for `test` queries of a specific `dialect` and generates a markdown report. Try running it with -h for the full list of arguments.

### Dataset Scripts

#### Scan Dataset
```shell
uv run scripts/scan_dataset.py mysql
```
This script goes through the dataset and aggregates various details such as the number of queries, tables, and databases.

#### Execute Queries
```shell
uv run scripts/execute_queries.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```

It executes the queries and checks for the successful completion. Query results are not verified at this point.

#### Validate Queries
```shell
uv run scripts/validate_queries.py mysql
```
This script validates the queries using an LLM and writes the results to a JSON file in the respective dataset directory. Environment variable `AZURE_OPENAI_ENDPOINT`, `AZURE_OPENAI_API_KEY`, and `AZURE_OPENAI_MODEL` must be set.

## Testing

The project includes comprehensive tests for the benchmarking functionality. All tests are written using pytest.

### Run All Tests
```shell
uv run pytest tests -v
```

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
