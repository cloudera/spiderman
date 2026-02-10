from argparse import ArgumentParser
from collections import defaultdict
from typing import Any, Optional
import re
import sqlglot
import pandas as pd

from scripts.core.dataset import DatasetDir, QuerySplit
from scripts.core.results_and_reports import ResultsAndReports
from scripts.utils.args import url_dialect_parser, test_split_parser
from scripts.core.factories import create_target_db
from scripts.utils.sha import df_to_sha


class SQLResultBenchmark:
    """
    Benchmark SQL generation results by comparing generated SQL queries
    with gold standard queries.
    """

    dataset: DatasetDir
    rr_dir: ResultsAndReports
    split: QuerySplit
    db_url: str
    scalar_tolerance: float

    def __init__(self, dataset: DatasetDir, rr_dir: ResultsAndReports, split: QuerySplit, db_url: str, scalar_tolerance: float = 1e-5):
        """
        Initialize the SQL Result Benchmark.

        Args:
            dataset: DatasetDir instance for accessing dataset files
            split: QuerySplit (train/test) to benchmark
            db_url: Database URL for query execution
            scalar_tolerance: Tolerance for floating-point comparisons (default: 1e-5)
        """
        self.dataset = dataset
        self.rr_dir = rr_dir
        self.split = split
        self.db_url = db_url
        self.scalar_tolerance = scalar_tolerance

    def _has_order_by(self, sql: str) -> bool:
        """
        Check if SQL query contains an ORDER BY clause.

        Args:
            sql: SQL query string

        Returns:
            True if query has ORDER BY clause, False otherwise
        """
        try:
            parsed = sqlglot.parse_one(sql, read='mysql')
            return parsed.find(sqlglot.exp.Order) is not None
        except Exception:
            # Fallback to regex if parsing fails
            return bool(re.search(r'\bORDER\s+BY\b', sql, re.IGNORECASE))

    def _normalize_value(self, val: Any) -> Any:
        """
        Normalize a value for comparison.

        Args:
            val: Value to normalize

        Returns:
            Normalized value
        """
        if val is None or val == '' or (isinstance(val, float) and pd.isna(val)):
            return None
        if isinstance(val, str):
            return val.strip()
        if isinstance(val, (int, float)):
            return val
        return str(val)

    def _compare_values(self, val1: Any, val2: Any) -> bool:
        """
        Compare two values with scalar tolerance for floats.

        Args:
            val1: First value
            val2: Second value

        Returns:
            True if values are equal within tolerance, False otherwise
        """
        v1 = self._normalize_value(val1)
        v2 = self._normalize_value(val2)

        if v1 is None and v2 is None:
            return True
        if v1 is None or v2 is None:
            return False

        # Both are numbers
        if isinstance(v1, (int, float)) and isinstance(v2, (int, float)):
            return abs(float(v1) - float(v2)) <= self.scalar_tolerance

        # Try converting strings to numbers for comparison
        try:
            f1 = float(v1)
            f2 = float(v2)
            return abs(f1 - f2) <= self.scalar_tolerance
        except (ValueError, TypeError):
            pass

        return v1 == v2

    def _result_to_frozenset(self, df: pd.DataFrame) -> frozenset:
        """
        Convert a DataFrame to a frozenset of tuples for set comparison.

        Args:
            df: DataFrame containing query results

        Returns:
            Frozenset of row tuples
        """
        return frozenset(tuple(self._normalize_value(v) for v in row) for row in df.values)

    def _find_best_column_permutation(self, gold_df: pd.DataFrame, pred_df: pd.DataFrame) -> Optional[list]:
        """
        Find the best permutation of predicted columns that matches gold columns.
        Uses itertools.permutations for small column counts, heuristic for larger.

        Args:
            gold_df: Gold standard DataFrame
            pred_df: Predicted DataFrame

        Returns:
            List of column indices representing the best permutation, or None if no match
        """
        import itertools

        if len(pred_df.columns) > 6:
            # Too many permutations, use heuristic: assume same order
            return list(range(len(pred_df.columns)))

        # Try all permutations and find the best match
        gold_set = self._result_to_frozenset(gold_df)
        best_match_size = 0
        best_perm = None

        for perm in itertools.permutations(range(len(pred_df.columns))):
            # Reorder pred_df columns according to this permutation
            reordered = pred_df.iloc[:, list(perm)]
            pred_set = self._result_to_frozenset(reordered)

            # Count matches
            match_size = len(gold_set & pred_set)
            if match_size > best_match_size:
                best_match_size = match_size
                best_perm = list(perm)

                # Early exit if perfect match
                if match_size == len(gold_set) and len(gold_set) == len(pred_set):
                    break

        return best_perm

    def _compare_results(self, gold_df: pd.DataFrame, pred_df: pd.DataFrame, has_order: bool) -> dict:
        """
        Compare two query results and compute metrics.

        Args:
            gold_df: Gold standard query results
            pred_df: Predicted query results
            has_order: Whether ORDER BY was present in the query

        Returns:
            Dictionary containing comparison metrics
        """
        metrics = {
            'exec_match': False,
            'exec_f1': 0.0,
            'data_match': False,  # Ignoring column names
            'exact_match': False,
            'normalized_match': False
        }

        # Check if column count matches (for data comparison)
        columns_match = list(gold_df.columns) == list(pred_df.columns)
        same_column_count = len(gold_df.columns) == len(pred_df.columns)

        # If columns don't match at all, skip detailed comparison
        if not columns_match and not same_column_count:
            return metrics

        # Only perform these comparisons if columns match exactly
        if columns_match:
            # Exact text match (including order and formatting)
            metrics['exact_match'] = gold_df.equals(pred_df)

            # Normalized match (case-insensitive, trimmed)
            gold_normalized = gold_df.map(lambda x: str(x).strip().lower() if pd.notna(x) else '')
            pred_normalized = pred_df.map(lambda x: str(x).strip().lower() if pd.notna(x) else '')
            metrics['normalized_match'] = gold_normalized.equals(pred_normalized)

        # Data comparison (ignoring column names) - only if same number of columns
        if same_column_count:
            # Rename columns to be identical for comparison
            generic_columns = [f'col_{i}' for i in range(len(gold_df.columns))]
            gold_renamed = gold_df.copy()
            gold_renamed.columns = generic_columns
            pred_renamed = pred_df.copy()
            pred_renamed.columns = generic_columns

        if has_order and same_column_count:
            # With ORDER BY: compare row by row, but find best column permutation first
            if len(gold_df) != len(pred_df):
                metrics['exec_f1'] = 0.0
            else:
                # Find best column permutation
                best_perm = self._find_best_column_permutation(gold_df, pred_df)

                if best_perm:
                    # Reorder predicted columns to match gold
                    pred_reordered = pred_df.iloc[:, best_perm].copy()

                    # Data match (ignoring column names but respecting row order)
                    data_matches = sum(
                        all(self._compare_values(gold_df.iloc[i, j], pred_reordered.iloc[i, j])
                            for j in range(len(gold_df.columns)))
                        for i in range(len(gold_df))
                    )
                    metrics['data_match'] = (data_matches == len(gold_df))
                    metrics['exec_f1'] = data_matches / len(gold_df) if len(gold_df) > 0 else 1.0

                    # Exec match only if columns also match
                    if columns_match:
                        metrics['exec_match'] = metrics['data_match']
                else:
                    metrics['exec_f1'] = 0.0
        elif same_column_count:
            # Without ORDER BY: treat as sets, trying column permutations
            # Find best column order permutation for pred to match gold
            best_perm = self._find_best_column_permutation(gold_df, pred_df)

            if best_perm:
                # Reorder predicted columns to match gold
                pred_reordered = pred_df.iloc[:, best_perm].copy()
                pred_reordered.columns = gold_df.columns

                # Now compare as sets
                gold_set = self._result_to_frozenset(gold_df)
                pred_set = self._result_to_frozenset(pred_reordered)

                metrics['data_match'] = (gold_set == pred_set)

                # Calculate F1
                if len(gold_set) == 0 and len(pred_set) == 0:
                    metrics['exec_f1'] = 1.0
                elif len(gold_set) == 0 or len(pred_set) == 0:
                    metrics['exec_f1'] = 0.0
                else:
                    intersection = len(gold_set & pred_set)
                    precision = intersection / len(pred_set)
                    recall = intersection / len(gold_set)
                    if precision + recall > 0:
                        metrics['exec_f1'] = 2 * precision * recall / (precision + recall)
                    else:
                        metrics['exec_f1'] = 0.0

                # Exec match only if columns also match
                if columns_match:
                    metrics['exec_match'] = metrics['data_match']

        return metrics

    def _categorize_error(self, error: Exception) -> str:
        """
        Categorize an error into standard error types.

        Args:
            error: Exception object

        Returns:
            Error category string
        """
        error_msg = str(error).lower()

        if any(kw in error_msg for kw in ['syntax', 'parse', 'grammar', 'unexpected']):
            return 'syntax_error'
        elif any(kw in error_msg for kw in ['timeout', 'time limit']):
            return 'timeout_error'
        elif any(kw in error_msg for kw in ['permission', 'denied', 'access']):
            return 'permission_error'
        else:
            return 'runtime_error'

    def _execute_queries_batch(self, queries_by_db: dict[str, list[tuple[int, str]]]) -> dict[int, tuple]:
        """
        Execute queries batched by database for efficiency.

        Args:
            queries_by_db: Dictionary mapping db_name to list of (query_idx, sql) tuples

        Returns:
            Dictionary mapping query_idx to (result_df, error_category, error_message) tuple
        """
        results = {}

        for db_name, queries in queries_by_db.items():
            query_sqls = [sql for _, sql in queries]

            try:
                with create_target_db(self.db_url, db_name) as db:
                    batch_results = db.execute_statements(query_sqls)

                    for (query_idx, _), result in zip(queries, batch_results):
                        if result is not None and len(result) > 0:
                            # Convert to DataFrame
                            df = pd.DataFrame(result[1:], columns=result[0])
                            results[query_idx] = (df, None, None)
                        else:
                            # Empty result
                            results[query_idx] = (pd.DataFrame(), None, None)
            except Exception as e:
                # If batch execution fails, try individual queries to isolate failures
                for query_idx, sql in queries:
                    try:
                        with create_target_db(self.db_url, db_name) as db:
                            result = db.execute_statements([sql])[0]
                            if result is not None and len(result) > 0:
                                df = pd.DataFrame(result[1:], columns=result[0])
                                results[query_idx] = (df, None, None)
                            else:
                                results[query_idx] = (pd.DataFrame(), None, None)
                    except Exception as query_error:
                        error_cat = self._categorize_error(query_error)
                        results[query_idx] = (None, error_cat, str(query_error))

        return results

    def benchmark(self) -> None:
        """
        Run comprehensive benchmark and generate markdown report.
        """
        sql_results = self.rr_dir.read_sql_results()
        total_queries = sql_results['total_queries']
        runs = sql_results['runs']

        source_queries = self.dataset.read_queries(self.split)
        source_queries = source_queries.head(total_queries) # Limit to queries used for the run

        # Validate source queries haven't changed
        source_sha = df_to_sha(source_queries)
        if source_sha != sql_results.get('source_sha'):
            raise ValueError(
                "Source queries have changed since SQL results were generated. "
                "Please regenerate SQL results or restore the original queries."
            )

        print(f"Benchmarking {len(runs)} runs against {total_queries} queries...")

        # Batch gold queries by database and separate results
        print("Executing gold standard queries...")
        gold_queries_by_db = defaultdict(list)

        for idx, row in source_queries.iterrows():
            gold_queries_by_db[row['database']].append((idx, row['sql']))

        # Execute all gold queries in batches
        gold_execution_results = self._execute_queries_batch(gold_queries_by_db)

        # Separate successful results from errors
        gold_results = {}
        gold_errors = {}

        for idx, row in source_queries.iterrows():
            result_df, error_cat, error_msg = gold_execution_results[idx]
            if result_df is not None:
                gold_results[idx] = (result_df, self._has_order_by(row['sql']))
            else:
                gold_errors[idx] = (error_cat, error_msg)

        print(f"Gold queries executed: {len(gold_results)}/{total_queries}")

        # Benchmark each run
        run_metrics = []
        all_mismatches = []  # Collect all mismatches for JSON output

        for run_idx, run in enumerate(runs):
            print(f"\nBenchmarking run {run_idx + 1}/{len(runs)}: {run['metadata']['app_name']} ({run['metadata']['service_name']} - {run['metadata']['model_details']})")

            metrics = {
                'metadata': run['metadata'],
                'total_queries': total_queries,
                'exec_match': 0,
                'data_match': 0,  # Ignoring column names
                'exec_f1_sum': 0.0,
                'exact_match': 0,
                'normalized_match': 0,
                'parse_success': 0,
                'runtime_success': 0,
                'errors': defaultdict(int),
                'error_examples': defaultdict(list)
            }

            # Batch predicted queries by database
            pred_queries_by_db = defaultdict(list)

            # Build batch query list while tracking not_generated errors
            for idx, row in source_queries.iterrows():
                if idx >= len(run['data']):
                    metrics['errors']['not_generated'] += 1
                    continue

                # Skip if gold query failed
                if idx in gold_errors:
                    continue

                pred_sql = run['data'][idx]
                pred_queries_by_db[row['database']].append((idx, pred_sql))

            # Execute all predicted queries in batches
            pred_execution_results = self._execute_queries_batch(pred_queries_by_db)

            # Process results
            for idx, row in source_queries.iterrows():
                # Skip if query not generated or gold failed
                if idx >= len(run['data']) or idx in gold_errors:
                    continue

                pred_sql = run['data'][idx]
                gold_df, has_order = gold_results[idx]
                pred_df, error_cat, error_msg = pred_execution_results[idx]

                if pred_df is not None:
                    metrics['parse_success'] += 1
                    metrics['runtime_success'] += 1

                    # Compare results
                    comparison = self._compare_results(gold_df, pred_df, has_order)

                    if comparison['exec_match']:
                        metrics['exec_match'] += 1
                    if comparison['data_match']:
                        metrics['data_match'] += 1
                    metrics['exec_f1_sum'] += comparison['exec_f1']

                    if comparison['exact_match']:
                        metrics['exact_match'] += 1
                    if comparison['normalized_match']:
                        metrics['normalized_match'] += 1

                    # Track mismatches for JSON
                    if not comparison['data_match']:
                        mismatch_reason = []
                        if len(gold_df.columns) != len(pred_df.columns):
                            mismatch_reason.append(f"Column count mismatch: gold={len(gold_df.columns)}, pred={len(pred_df.columns)}")
                        elif list(gold_df.columns) != list(pred_df.columns):
                            mismatch_reason.append("Column names differ")
                        if len(gold_df) != len(pred_df):
                            mismatch_reason.append(f"Row count mismatch: gold={len(gold_df)}, pred={len(pred_df)}")
                        if not mismatch_reason:
                            mismatch_reason.append("Data values differ")

                        all_mismatches.append({
                            'run_idx': run_idx,
                            'query_id': row['id'],
                            'database': row['database'],
                            'question': row['question'],
                            'gold_query': row['sql'],
                            'generated_query': pred_sql.replace('\n', ' '),
                            'failure_reason': '; '.join(mismatch_reason)
                        })
                else:
                    # Query failed - track error metrics
                    metrics['errors'][error_cat] += 1

                    # Store error examples (limited to 3 per category)
                    if len(metrics['error_examples'][error_cat]) < 3:
                        metrics['error_examples'][error_cat].append({
                            'question': row['question'],
                            'gold_sql': row['sql'],
                            'pred_sql': pred_sql,
                            'error': error_msg[:200]  # Truncate long errors
                        })

                    # Track parse vs runtime (syntax errors = parse failures, others = runtime failures)
                    if error_cat != 'syntax_error':
                        metrics['parse_success'] += 1  # Parsed but runtime failed

                    # Track errors for JSON
                    all_mismatches.append({
                        'run_idx': run_idx,
                        'query_id': row['id'],
                        'database': row['database'],
                        'question': row['question'],
                        'gold_query': row['sql'],
                        'generated_query': pred_sql.replace('\n', ' '),
                        'failure_reason': f"{error_cat}: {error_msg[:200]}"
                    })

            run_metrics.append(metrics)

        # Generate markdown report and mismatches JSON
        self.rr_dir.generate_sql_benchmark_report(run_metrics, total_queries, all_mismatches)


if __name__ == "__main__":
    parser = ArgumentParser(
        description="SpiderMan - Benchmark results for a specific dialect and split",
        parents=[url_dialect_parser, test_split_parser]
    )
    parser.add_argument(
        "-t", "--tolerance",
        help="Scalar tolerance for floating-point comparisons (default: 1e-5)",
        type=float,
        default=1e-5
    )
    args = parser.parse_args()

    split = QuerySplit(args.split)
    dataset_dir = DatasetDir(args.dialect)
    rr_dir = ResultsAndReports(args.dialect, split)

    print(f"Benchmarking {split.value} SQL results for {dataset_dir.dialect} dialect")
    print(f"Database URL: {args.url}")
    print(f"Scalar tolerance: {args.tolerance}")

    benchmarker = SQLResultBenchmark(dataset_dir, rr_dir, split, args.url, args.tolerance)
    benchmarker.benchmark()

    print(f"\nBenchmark completed successfully.")
