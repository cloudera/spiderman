import json
import os
from argparse import ArgumentParser

from openai import AzureOpenAI

from scripts.core.dataset import DatasetDir, QuerySplit, TABLE_DELIM
from scripts.utils.args import dialect_parser
from scripts.utils.iter import bar_iter


class LLMValidator:
    def __init__(self, dataset: DatasetDir):
        self.dataset = dataset
        self.db_schema_cache: dict[str, str] = {}
        self.client = AzureOpenAI(
            azure_endpoint= os.environ.get("AZURE_OPENAI_ENDPOINT", ""),
            api_version="2024-12-01-preview",
            api_key=os.environ.get("AZURE_OPENAI_API_KEY")
        )

    def validate_query(self, db_name: str, question: str, sql: str) -> dict:
        """
        Validate a SQL query and get a corrected version if invalid.

        Returns:
            None if the query is valid
            dict if invalid with keys: reason, corrected_sql
        """
        if db_name not in self.db_schema_cache:
            self.db_schema_cache[db_name] = TABLE_DELIM.join(self.dataset.read_schema(db_name))
        schema = self.db_schema_cache[db_name]
        dialect = self.dataset.dialect

        # Construct validation prompt
        prompt = f"""You are a SQL validation expert. Validate if the given SQL query correctly answers the natural language question based on the provided database schema.

SQL Dialect: {dialect}
Database: {db_name}

Database Schema:
```sql
{schema}
```

Natural Language Question: {question}

SQL Query to Validate:
```sql
{sql}
```

Please analyze:
1. Does the SQL query have correct syntax for {dialect}?
2. Does the SQL query reference only tables and columns that exist in the schema?
3. Does the SQL query logically answer the natural language question?
4. Are there any semantic errors (e.g., wrong joins, incorrect aggregations, missing filters)?

If the SQL query is VALID, respond with a JSON object in this format: {{"status": "VALID"}}

If the SQL query is INVALID, respond with a JSON object in this format:
{{
    "reason": "Brief explanation of what is wrong",
    "corrected_sql": "The corrected SQL query that properly answers the question"
}}"""

        response = self.client.chat.completions.create(
            model=os.environ.get("AZURE_OPENAI_MODEL", ""),
            messages=[
                {"role": "system", "content": "You are a SQL validation expert. Be precise and thorough. Respond only with valid JSON."},
                {"role": "user", "content": prompt}
            ],
            response_format={"type": "json_object"}
        )

        content = response.choices[0].message.content
        return json.loads(content.strip() if content else "")

    def validate_queries(self, split: QuerySplit):
        queries_df = self.dataset.read_queries(split)

        invalid_count = 0
        total_count = 0

        validation_results: list[dict[str, str]] = []

        queries = list(queries_df.to_dict('records'))
        for row, _bar in bar_iter(queries):
            query_id = row['id']
            db_name = row['database']
            question = row['question']
            sql = row['sql']

            total_count += 1
            validation_result = self.validate_query(db_name, question, sql)

            if "reason" in validation_result:
                invalid_count += 1
                validation_results.append({
                    "query_id": query_id,
                    "database": db_name,
                    "question": question,
                    "original_sql": sql,
                    **validation_result
                })

        # Write JSON output
        json_path = self.dataset.write_json(f"invalid_queries_{split.value}.json", validation_results)

        print(f"\nValidation Summary: {total_count - invalid_count}/{total_count} queries are valid")
        print(f"Invalid queries: {invalid_count}")
        print(f"Results written to: {json_path}")


if __name__ == "__main__":
    parser = ArgumentParser(
        description="SpiderMan - Validate queries using an LLM",
        parents=[dialect_parser]
    )
    args = parser.parse_args()

    validator = LLMValidator(DatasetDir(args.dialect))

    print("Validating test queries...")
    validator.validate_queries(QuerySplit.TEST)

    print("Validating train queries...")
    validator.validate_queries(QuerySplit.TRAIN)

    print("Validation completed.")
