import re
from typing import Callable

from sqlglot import parse_one, expressions as exp
from sqlglot.generator import Generator
from sqlglot.dialects.hive import Hive

from . import Transpiler


# HiveTranspiler is a temporary implementation until the following issues are fixed in sqlglot
class HiveTranspiler(Transpiler):
    def __init__(self, pretty: bool) -> None:
        super().__init__("hive", pretty)

    def transpile(self, sql: str) -> str:

        if "CREATE TABLE" in sql:
            sql = table_def_modifier(sql, pre_modifier)
            sql = super().transpile(sql)
            sql = sql.replace("\n   ", "\n    ")
            sql = table_def_modifier(sql, post_modifier)

            sql = sql + "\nROW FORMAT DELIMITED\nFIELDS TERMINATED BY ','\nSTORED AS TEXTFILE"
            sql = sql + "\nTBLPROPERTIES ('skip.header.line.count'='1')"
        else:
            sql = sql.replace("= ''", "IS NULL")
            sql = super().transpile(sql)

        return sql


def pre_modifier(line: str) -> str:
    # A hack as SQLGlot doesn't support UNIQUE constraints in Hive
    if "UNIQUE" in line:
        line = line.replace("UNIQUE (`", "PRIMARY KEY (`UNIQUE-")
    return line


def post_modifier(line: str) -> str:

    if "INDEX" in line:
        return ""

    line = re.sub(r'INT\(\d+\)', 'INT', line)
    line = line.split(" DEFAULT")[0] # Removes the text DEFAULT and everything after it

    if "PRIMARY KEY" in line or "FOREIGN KEY" in line:
        line = line + " DISABLE NOVALIDATE"
    if "PRIMARY KEY (`UNIQUE-" in line:
        line = line.replace("PRIMARY KEY (`UNIQUE-", "UNIQUE (`")
    if "NOT NULL" in line:
        line = line.replace(" NOT NULL", "")

    return line


def table_def_modifier(sql: str, modifier: Callable) -> str:
    sql_lines = sql.splitlines()

    col_def = "\n".join(sql_lines[1:-1])
    col_def_arr = re.split(r'(?<!`),\n', col_def) # Using regex to get multi-line foreign key definition in one line

    modified_arr = []
    for line in col_def_arr:
        modified_line = modifier(line)
        if modified_line:
            modified_arr.append(modified_line)

    modified_col_def = ",\n".join(modified_arr)

    return f"{sql_lines[0]}\n{modified_col_def}\n{sql_lines[-1]}"
