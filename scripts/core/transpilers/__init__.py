import sqlglot


class Transpiler:
    target_dialect: str
    source_dialect: str = "mysql"
    pretty: bool

    def __init__(self, dialect: str, pretty: bool) -> None:
        super().__init__()
        self.target_dialect = dialect
        self.pretty = pretty

    def transpile(self, sql: str) -> str:
        return sqlglot.transpile(
            sql,
            read=self.source_dialect,
            write=self.target_dialect,
            pretty=self.pretty
        )[0]
