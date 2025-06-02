from .transpilers import Transpiler
from .target_dbs import TargetDB


def create_transpiler(dialect: str, pretty: bool) -> Transpiler:
  if dialect == "hive":
    from .transpilers.hive import HiveTranspiler
    return HiveTranspiler(pretty)
  elif dialect == "mysql":
    raise ValueError("MySQL is the source dialect, not a target dialect.")
  else:
    return Transpiler(dialect, pretty)  # Default case


def create_target_db(url: str, db_name: str) -> TargetDB:
    """Create a TargetDB instance based on the provided URL and database name."""

    if url.startswith('hive'):
      from .target_dbs.hive_target_db import HiveTargetDB
      return HiveTargetDB(url, db_name)

    return TargetDB(url, db_name)
