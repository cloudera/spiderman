from urllib.parse import urlparse
from argparse import ArgumentParser, Namespace


def _extract_dialect(url: str) -> str:
    parsed_url = urlparse(url)
    return parsed_url.scheme.split("+")[0]

def parse_url_dialect(description: str) -> Namespace:
    """Get command line arguments url and dialect."""

    parser = ArgumentParser(description=f"SpiderMan - {description}")

    parser.add_argument("url", help="SQLAlchemy friendly URL to the target database")
    parser.add_argument("-d", "--dialect", help="Target dialect. Calculated from the URL by default.")

    args = parser.parse_args()

    if not args.dialect:
        setattr(args, "dialect", _extract_dialect(args.url))

    return args


def parse_dialect(description: str, default: str) -> Namespace:
    """Get command line argument dialect."""

    parser = ArgumentParser(description=f"SpiderMan - {description}")

    parser.add_argument("dialect", help="Target dialect.", default=default, nargs='?')

    args = parser.parse_args()

    return args
