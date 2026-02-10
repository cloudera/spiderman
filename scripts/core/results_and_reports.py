from scripts.core.dataset import QuerySplit
import pandas as pd
import json
import os
from os import path
from datetime import datetime
import json

from scripts.utils.sha import df_to_sha


class ResultsAndReports:
    dialect: str
    split: QuerySplit

    results_file_path: str
    benchmark_file_path: str
    mismatches_file_path: str

    def __init__(self, dialect: str, split: QuerySplit):
        self.dialect = dialect
        self.split = split

        base_path = path.join(
            "./results_and_reports",
            f"{self.dialect}_{self.split.value}"
        )

        self.results_file_path = path.join(base_path, 'sql_results.json')
        self.report_file_path = path.join(base_path, 'sql_benchmark_report.md')
        self.mismatches_file_path = path.join(base_path, 'sql_benchmark_mismatches.json')

    def write_sql_results(self, source_queries: pd.DataFrame, metadata: dict, data: list[str]) -> None:

        # Hash the source queries to detect changes across runs
        source_sha = df_to_sha(source_queries)

        # Increment the data version when the structure of the data changes
        data_version = 1

        # Read existing data if file exists
        if os.path.exists(self.results_file_path):
            with open(self.results_file_path, 'r', encoding='utf-8') as f:
                # Let json.JSONDecodeError raise
                sql_results: dict = json.load(f)

                # Validate source hasn't changed
                if source_sha != sql_results.get('source_sha'):
                    raise ValueError(
                        "Source queries have changed across runs. "
                        f"Please delete the file {self.results_file_path} and re-run."
                    )

                # Validate data version hasn't changed
                if data_version != sql_results.get('data_version'):
                    raise ValueError(
                        "Data version has changed across runs. "
                        f"Please delete the file {self.results_file_path} and re-run."
                    )
        else:
            sql_results = {
                'source_sha': source_sha,
                'data_version': data_version,
                'dialect': self.dialect,
                'split': self.split.value,
                'total_queries': len(source_queries),
                'runs': []
            }

        # Append new result
        sql_results['runs'].append({
            'metadata': metadata,
            'data': data
        })

        # Write back to file
        with open(self.results_file_path, 'w', encoding='utf-8') as f:
            json.dump(sql_results, f, indent=4, ensure_ascii=False)

        print(f"Wrote SQL results to {self.results_file_path}")

    def read_sql_results(self) -> dict:
        with open(self.results_file_path, 'r', encoding='utf-8') as f:
            return json.load(f)

    def generate_sql_benchmark_report(self, run_metrics: list[dict], total_queries: int, all_mismatches: list[dict]):
        """
        Generate a comprehensive markdown report and mismatches JSON.

        Args:
            run_metrics: List of metrics for each run
            total_queries: Total number of queries benchmarked
            all_mismatches: List of all mismatch details

        Generates a markdown report and JSON file in the dataset directory.
        """

        lines = []
        lines.append("# SQL Generation Benchmark Report\n")
        lines.append(f"**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\\\n")
        lines.append(f"**Dataset**: {self.dialect}\\\n")
        lines.append(f"**Split**: {self.split.value}\\\n")
        lines.append(f"**Total Queries**: {total_queries}\n")
        lines.append("\n---\n\n")

        # Metrics explanation section
        lines.append("## Metrics Explanation\n\n")
        lines.append("### Execution Metrics\n\n")
        lines.append("- **DataMatch**: Percentage of queries where data values are identical, ignoring column names (most meaningful for semantic correctness)\n")
        lines.append("- **ExecMatch**: Percentage of queries where results are identical including both data values AND column names (most strict)\n")
        lines.append("- **ExecF1**: F1 score of result set accuracy. For ordered queries: row-by-row comparison. For unordered: set-based comparison. Range: 0.0-1.0\n")
        lines.append("- **Exact Match**: Percentage where result DataFrames are byte-for-byte identical (very strict, includes formatting)\n")
        lines.append("- **Normalized Match**: Percentage where results match after normalization (lowercase + trimmed whitespace)\n\n")
        lines.append("### Success Rate Metrics\n\n")
        lines.append("- **Parse Success**: Percentage of generated SQL with valid syntax (no syntax errors)\n")
        lines.append("- **Runtime Success**: Percentage of generated SQL that executes without errors (no table/column not found, type errors, etc.)\n\n")
        lines.append("**Key Insight**: DataMatch is often the most meaningful metric as it focuses on semantic correctness while allowing different column naming conventions.\n\n")
        lines.append("---\n\n")

        # Overall summary table
        lines.append("## Overall Summary\n\n")
        lines.append("| Run | App Name | Service | Model | DataMatch | ExecMatch | ExecF1 | Exact Match | Normalized Match | Parse Success | Runtime Success |\n")
        lines.append("|-----|----------|---------|-------|-----------|-----------|--------|-------------|------------------|---------------|----------------|\n")

        for idx, metrics in enumerate(run_metrics):
            meta = metrics['metadata']
            data_match_pct = (metrics['data_match'] / total_queries * 100)
            exec_match_pct = (metrics['exec_match'] / total_queries * 100)
            exec_f1_avg = (metrics['exec_f1_sum'] / total_queries)
            exact_match_pct = (metrics['exact_match'] / total_queries * 100)
            norm_match_pct = (metrics['normalized_match'] / total_queries * 100)
            parse_pct = (metrics['parse_success'] / total_queries * 100)
            runtime_pct = (metrics['runtime_success'] / total_queries * 100)

            lines.append(f"| {idx + 1} | {meta['app_name']} | {meta['service_name']} | {meta['model_details']} | "
                        f"{data_match_pct:.1f}% | {exec_match_pct:.1f}% | {exec_f1_avg:.3f} | {exact_match_pct:.1f}% | "
                        f"{norm_match_pct:.1f}% | {parse_pct:.1f}% | {runtime_pct:.1f}% |\n")

        lines.append("\n")

        # Detailed metrics for each run
        for idx, metrics in enumerate(run_metrics):
            lines.append(f"## Run {idx + 1}: {metrics['metadata']['app_name']} ({metrics['metadata']['service_name']} - {metrics['metadata']['model_details']})\n\n")

            # Core metrics
            lines.append("### Core Execution Metrics\n\n")
            lines.append(f"- **Data Match (Ignoring Column Names)**: {metrics['data_match']}/{total_queries} ({metrics['data_match']/total_queries*100:.2f}%)\n")
            lines.append(f"  - *Same data values, ignoring column name differences*\n")
            lines.append(f"- **Execution Accuracy (ExecMatch)**: {metrics['exec_match']}/{total_queries} ({metrics['exec_match']/total_queries*100:.2f}%)\n")
            lines.append(f"  - *Exact match including column names*\n")
            lines.append(f"- **Average ExecF1**: {metrics['exec_f1_sum']/total_queries:.4f}\n")
            lines.append(f"- **Exact Text Match**: {metrics['exact_match']}/{total_queries} ({metrics['exact_match']/total_queries*100:.2f}%)\n")
            lines.append(f"- **Normalized Match**: {metrics['normalized_match']}/{total_queries} ({metrics['normalized_match']/total_queries*100:.2f}%)\n")

            # Success rates
            lines.append("### Execution Success Rates\n\n")
            lines.append(f"- **Parse/Compile Success**: {metrics['parse_success']}/{total_queries} ({metrics['parse_success']/total_queries*100:.2f}%)\n")
            lines.append(f"- **Runtime Success**: {metrics['runtime_success']}/{total_queries} ({metrics['runtime_success']/total_queries*100:.2f}%)\n\n")

            # Error breakdown
            if metrics['errors']:
                lines.append("### Error Categories\n\n")
                lines.append("| Error Type | Count | Percentage |\n")
                lines.append("|------------|-------|------------|\n")

                sorted_errors = sorted(metrics['errors'].items(), key=lambda x: x[1], reverse=True)
                for error_type, count in sorted_errors:
                    pct = count / total_queries * 100
                    lines.append(f"| {error_type.replace('_', ' ').title()} | {count} | {pct:.2f}% |\n")

                lines.append("\n")

                # Error examples
                lines.append("### Error Examples\n\n")
                for error_type, examples in metrics['error_examples'].items():
                    if examples:
                        lines.append(f"#### {error_type.replace('_', ' ').title()}\n\n")
                        for ex_idx, example in enumerate(examples, 1):
                            lines.append(f"**Example {ex_idx}:**\n\n")
                            lines.append(f"- **Question**: {example['question']}\n")
                            lines.append(f"- **Gold SQL**: ```{example['gold_sql']}```\n")
                            lines.append(f"- **Generated SQL**: ```{example['pred_sql']}```\n")
                            lines.append(f"- **Error**: {example['error']}\n\n")

        # Write report
        with open(self.report_file_path, 'w', encoding='utf-8') as f:
            f.writelines(lines)
        print(f"\nBenchmark report saved to: {self.report_file_path}")

        # Write mismatches JSON
        if all_mismatches:
            with open(self.mismatches_file_path, 'w', encoding='utf-8') as f:
                json.dump(all_mismatches, f, indent=4, ensure_ascii=False)
            print(f"Mismatches JSON saved to: {self.mismatches_file_path}")
        else:
            print("No mismatches found - all queries matched perfectly!")
