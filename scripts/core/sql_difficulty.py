"""SQL difficulty grading module."""
import sqlglot
from sqlglot import expressions as exp


def calculate_nesting_depth(node, current_depth: int = 0) -> int:
    """
    Calculate maximum nesting depth of subqueries.

    Args:
        node: SQLGlot expression node
        current_depth: Current depth level

    Returns:
        Maximum nesting depth
    """
    max_depth = current_depth

    for child in node.iter_expressions():
        if isinstance(child, exp.Subquery):
            child_depth = calculate_nesting_depth(child, current_depth + 1)
            max_depth = max(max_depth, child_depth)
        else:
            child_depth = calculate_nesting_depth(child, current_depth)
            max_depth = max(max_depth, child_depth)

    return max_depth


def calculate_sql_difficulty(sql: str, dialect: str = 'mysql') -> dict:
    """
    Calculate SQL query difficulty on a scale of 1-5.

    Args:
        sql: SQL query string
        dialect: SQL dialect (default: mysql)

    Returns:
        Dictionary with score, difficulty (1-5), and detailed metrics
    """
    try:
        parsed = sqlglot.parse_one(sql, read=dialect)

        metrics = {
            'num_tables': len(list(parsed.find_all(exp.Table))),
            'num_joins': len(list(parsed.find_all(exp.Join))),
            'num_subqueries': len(list(parsed.find_all(exp.Subquery))),
            'num_aggregates': len(list(parsed.find_all(exp.AggFunc))),
            'num_window_funcs': len(list(parsed.find_all(exp.Window))),
            'has_group_by': parsed.find(exp.Group) is not None,
            'has_having': parsed.find(exp.Having) is not None,
            'has_union': parsed.find(exp.Union) is not None,
            'max_nesting_depth': calculate_nesting_depth(parsed),
        }

        # Calculate weighted score
        score = (
            metrics['num_joins'] * 2 +
            metrics['num_subqueries'] * 3 +
            metrics['num_aggregates'] * 1.5 +
            metrics['num_window_funcs'] * 4 +
            metrics['max_nesting_depth'] * 2 +
            (2 if metrics['has_group_by'] else 0) +
            (3 if metrics['has_having'] else 0) +
            (3 if metrics['has_union'] else 0)
        )

        # Map score to 1-5 difficulty scale
        # Thresholds calibrated based on SpiderMan dataset distribution
        if score < 1.0:
            difficulty = 1  # Very Easy: Simple SELECT, single table
        elif score < 2.0:
            difficulty = 2  # Easy: Basic JOINs, simple WHERE
        elif score < 3.5:
            difficulty = 3  # Medium: Multiple JOINs, GROUP BY, aggregations
        elif score < 6.0:
            difficulty = 4  # Hard: Subqueries, HAVING, complex aggregations
        else:
            difficulty = 5  # Very Hard: Nested subqueries, window functions, CTEs

        return {
            'score': score,
            'difficulty': difficulty,  # 1-5 scale
            'metrics': metrics
        }
    except Exception:
        # If parsing fails, return default difficulty
        return {
            'score': 0,
            'difficulty': 1,
            'metrics': {
                'num_tables': 0,
                'num_joins': 0,
                'num_subqueries': 0,
                'num_aggregates': 0,
                'num_window_funcs': 0,
                'has_group_by': False,
                'has_having': False,
                'has_union': False,
                'max_nesting_depth': 0,
            }
        }
