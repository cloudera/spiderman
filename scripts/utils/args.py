from urllib.parse import urlparse
from argparse import Action, ArgumentParser, Namespace
from typing import Any, Optional, Sequence

from scripts.core.dataset import QuerySplit


"""
Get command line arguments url and dialect.

Example:
```shell
uv run scripts/script_name.py 'mysql+mysqlconnector://root:PeterParker@localhost:3306'
```
The dialect is calculated from the URL and is not needed to be passed separately.
But if needed -d/--dialect argument is available.
"""
url_dialect_parser = ArgumentParser(add_help=False)

class ExtractDialectAction(Action):
    def __call__(self, parser: ArgumentParser, namespace: Namespace, values: str | Sequence[Any] | None, option_string: Optional[str] = None):
        if not isinstance(values, str):
            raise ValueError("Expected a string value for URL")
        setattr(namespace, self.dest, values)
        if not getattr(namespace, 'dialect', None):
            parsed_url = urlparse(values)
            dialect = parsed_url.scheme.split("+")[0]
            setattr(namespace, 'dialect', dialect)

url_dialect_parser.add_argument(
    "url",
    help="SQLAlchemy friendly URL to the target database",
    action=ExtractDialectAction
)

url_dialect_parser.add_argument(
    "-d", "--dialect",
    help="Target dialect. Calculated from the URL by default.",
)


"""
Get command line argument dialect.

Example:
```shell
uv run scripts/script_name.py mysql
```
"""
dialect_parser = ArgumentParser(add_help=False)

dialect_parser.add_argument(
    "dialect",
    help="Target dialect."
)

"""
Get command line argument split.

Example:
```shell
uv run scripts/script_name.py mysql -s test
```
The split is one of the following: train, test. Defaults to test.
"""
test_split_parser = ArgumentParser(add_help=False)
test_split_parser.add_argument(
    "-s", "--split",
    help="Query split to use. Defaults to test.",
    default=QuerySplit.TEST.value,
    choices=[split.value for split in QuerySplit]
)
