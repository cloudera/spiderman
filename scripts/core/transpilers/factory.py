from . import Transpiler


def create_transpiler(dialect: str, pretty: bool) -> Transpiler:
  if dialect == "hive":
    from .hive import HiveTranspiler
    return HiveTranspiler(pretty)
  elif dialect == "mysql":
    raise ValueError("MySQL is the source dialect, not a target dialect.")
  else:
    return Transpiler(dialect, pretty)  # Default case
