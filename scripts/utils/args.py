import argparse


def get_args(description):
    parser = argparse.ArgumentParser(description=f"SpiderMan - {description}")

    parser.add_argument(
        "url",
        help="Connection URL for destination database. Eg: hive://<address>:10000.\
                        More details at https://docs.sqlalchemy.org/en/20/core/engines.html#database-urls"
    )

    parser.add_argument(
        "-s",
        "--skip-dbs",
        nargs='+',
        help="Names of databases to be skipped while performing the operation"
    )

    return parser.parse_args()
