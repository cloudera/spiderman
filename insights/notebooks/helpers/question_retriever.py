import os
import math
import re
import json
import pandas as pd
import numpy as np
from matplotlib.cm import hsv
from matplotlib.colors import ListedColormap


def _read_csv(file_path: str) -> pd.DataFrame:
    """
    Reads a CSV file and returns its DataFrame.
    
    Args:
    file_path (str): The path to the CSV file.
    
    Returns:
    pd.DataFrame: The DataFrame of the CSV file.
    """
    try:
        return pd.read_csv(file_path)
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")
        return pd.DataFrame()


def _process_folder(folder_path: str, process_file_func: callable) -> list:
    """
    Processes all CSV files in a folder using the provided function.
    
    Args:
    folder_path (str): The path to the folder containing CSV files.
    process_file_func (function): The function to process each CSV file.
    
    Returns:
    list: A list of results from processing each CSV file.
    """
    results = []
    for file in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file)
        if file_path.lower().endswith('.csv'):
            result = process_file_func(file_path)
            if result is not None:
                results.append(result)
    return results
    

def _read_and_label_csv(file_path: str, query_type: str) -> pd.DataFrame:
    """
    Reads a CSV file, adds a 'type' column, and returns the DataFrame.
    
    Args:
    file_path (str): The path to the CSV file.
    query_type (str): The type of queries ('train' or 'test').
    
    Returns:
    pd.DataFrame: The labeled DataFrame of the CSV file.
    """
    df = _read_csv(file_path)
    if not df.empty:
        df['type'] = query_type
    return df


def _count_unique_questions_in_file(file_path: str) -> int:
    """
    Counts the number of unique questions in a CSV file.
    
    Args:
    file_path (str): The path to the CSV file.
    
    Returns:
    int: The number of unique questions.
    """
    df = _read_csv(file_path)
    if not df.empty:
        return df['question'].nunique()
    return 0


def _collect_questions_from_file(file_path: str) -> list:
    """
    Collects unique questions from a CSV file.
    
    Args:
    file_path (str): The path to the CSV file.
    
    Returns:
    list: A list of questions.
    """
    df = _read_csv(file_path)
    if not df.empty:
        return df['question'].unique().tolist()
    return []

    
def count_unique_questions(root_folder: str) -> dict:
    """
    Counts the number of unique questions in CSV files within each subfolder of the specified root folder.
    
    Args:
    root_folder (str): The path to the root folder containing subfolders with CSV files.
    
    Returns:
    dict: A dictionary where the keys are subfolder names and the values are the total count of unique questions in each subfolder.
    """
    result_dict = {}
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        if os.path.isdir(folder_path):
            unique_counts = _process_folder(folder_path, _count_unique_questions_in_file)
            result_dict[folder] = sum(unique_counts)
    return result_dict


def get_all_questions(root_folder: str) -> pd.DataFrame:
    """
    Collects all database names and their respective questions from CSV files within each subfolder of the specified root folder.
    
    Args:
    root_folder (str): The path to the root folder containing subfolders with CSV files.
    
    Returns:
    pd.DataFrame: A DataFrame with two columns - 'database' and 'question', listing each question along with its corresponding database.
    """
    data = []
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        if os.path.isdir(folder_path):
            questions = _process_folder(folder_path, _collect_questions_from_file)
            for question in sum(questions, []):
                data.append((folder, question))
    return pd.DataFrame(data, columns=['database', 'question'])


def combine_queries(root_folder: str, output_file: str) -> pd.DataFrame:
    """
    Combines train_queries.csv and test_queries.csv files from each subfolder into a single CSV file
    with an additional 'type' column indicating 'train' or 'test'.
    
    Args:
    root_folder (str): The path to the root folder containing subfolders with CSV files.
    output_file (str): The path to the output CSV file.
    
    Returns:
    pd.DataFrame: The combined DataFrame with 'type' column.
    """
    combined_df = pd.DataFrame()
    
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        if os.path.isdir(folder_path):
            train_file_path = os.path.join(folder_path, 'train_queries.csv')
            test_file_path = os.path.join(folder_path, 'test_queries.csv')
            
            if os.path.exists(train_file_path):
                train_df = _read_and_label_csv(train_file_path, 'train')
                combined_df = pd.concat([combined_df, train_df], ignore_index=True)
                
            if os.path.exists(test_file_path):
                test_df = _read_and_label_csv(test_file_path, 'test')
                combined_df = pd.concat([combined_df, test_df], ignore_index=True)
    
    combined_df.to_csv(output_file, index=False)
    print(f"Combined CSV file saved to {output_file}")
    return combined_df


def _load_sql_keywords(file_path: str) -> dict:
    """
    Loads SQL keywords from a JSON file.
    
    Args:
    file_path (str): The path to the JSON file.
    
    Returns:
    dict: A dictionary containing categorized SQL keywords if the file is valid; otherwise, an empty dictionary.
    """
    if not os.path.isfile(file_path):
        print(f"Error: The file path {file_path} does not exist or is not a file.")
        return {}
    
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)
            if not all(key in data for key in ['clauses', 'operators', 'joins', 'aggregate_functions', 'scalar_functions', 'system_functions', 'transaction_control', 'constraints', 'database_objects']):
                print(f"Error: Missing one or more keys in the JSON file {file_path}.")
                return {}
            return data
    except json.JSONDecodeError as e:
        print(f"Error loading JSON from {file_path}: {str(e)}")
        return {}
    except IOError as e:
        print(f"Error opening file {file_path}: {str(e)}")
        return {}
    except Exception as e:
        print(f"Unexpected error loading keywords from {file_path}: {str(e)}")
        return {}


def _extract_sql_keywords(sql_query: str, keywords_dict: dict) -> tuple:
    """
    Extracts SQL keywords from a SQL query and returns both all keywords and unique keywords,
    preserving their order of appearance.

    Args:
    sql_query (str): The SQL query string.
    keywords_dict (dict): A dictionary of categorized SQL keywords.

    Returns:
    tuple: A tuple containing two strings:
           - The first string lists all SQL keywords (including duplicates) in the order they appear, separated by commas.
           - The second string lists unique SQL keywords in the order of their first appearance, separated by commas.
    """
    keywords = []
    for category in keywords_dict.values():
        keywords.extend(category)
    
    #pattern = r'\b(' + '|'.join(re.escape(keyword) for keyword in keywords) + r')\b'
    pattern = r'\b(?<![\w\.])(' + '|'.join(re.escape(keyword) for keyword in keywords) + r')(?![\w\.])\b'
    sql_keywords = re.findall(pattern, sql_query, re.IGNORECASE)

    keywords_all = ', '.join(keyword.upper() for keyword in sql_keywords)
    
    seen = set()
    unique_keywords = []
    for keyword in sql_keywords:
        upper_keyword = keyword.upper()
        if upper_keyword not in seen:
            seen.add(upper_keyword)
            unique_keywords.append(upper_keyword)
    
    unique_keywords_str = ', '.join(unique_keywords)
    
    return keywords_all, unique_keywords_str


def add_keywords(csv_file_path: str, keywords_file_path: str, output_file: str) -> pd.DataFrame:
    """
    Reads a CSV file, extracts SQL keywords from each query, and adds two new columns: 
    'keywords_all' (for all keywords including duplicates) and 'unique_keywords' (for unique keywords).

    Args:
    csv_file_path (str): The path to the CSV file containing SQL queries.
    keywords_file_path (str): The path to the JSON file containing SQL keywords.
    output_file (str): The path to the output CSV file.

    Returns:
    pd.DataFrame: The updated DataFrame with the new 'keywords_all' and 'unique_keywords' columns.
    """
    if not os.path.isfile(csv_file_path):
        print(f"Error: The CSV file path {csv_file_path} does not exist or is not a file.")
        return pd.DataFrame()
    
    output_dir = os.path.dirname(output_file)
    if output_dir and not os.path.isdir(output_dir):
        print(f"Error: The output directory {output_dir} does not exist.")
        return pd.DataFrame()

    keywords_dict = _load_sql_keywords(keywords_file_path)
    
    if not keywords_dict:
        print("No keywords loaded, cannot process CSV file.")
        return pd.DataFrame()

    try:
        df = pd.read_csv(csv_file_path)
    except pd.errors.EmptyDataError:
        print(f"Error: The CSV file {csv_file_path} is empty.")
        return pd.DataFrame()
    except pd.errors.ParserError as e:
        print(f"Error parsing CSV file {csv_file_path}: {str(e)}")
        return pd.DataFrame()
    except Exception as e:
        print(f"Unexpected error reading CSV file {csv_file_path}: {str(e)}")
        return pd.DataFrame()

    df[['keywords_all', 'unique_keywords']] = df['sql'].apply(lambda query: pd.Series(_extract_sql_keywords(query, keywords_dict)))

    try:
        df.to_csv(output_file, index=False)
        print(f"CSV file saved to {output_file}")
    except IOError as e:
        print(f"Error saving CSV file {output_file}: {str(e)}")

    return df
    

def generate_colormap(number_of_distinct_colors: int = 80) -> ListedColormap:
    """
    Generates a colormap with a specified number of distinct colors.
    
    Args:
    number_of_distinct_colors (int): The number of distinct colors to generate. Default is 80.
    
    Returns:
    ListedColormap: A colormap with the specified number of distinct colors.
    """
    if number_of_distinct_colors == 0:
        number_of_distinct_colors = 80

    number_of_shades = 7
    number_of_distinct_colors_with_multiply_of_shades = int(math.ceil(number_of_distinct_colors / number_of_shades) * number_of_shades)

    linearly_distributed_nums = np.arange(number_of_distinct_colors_with_multiply_of_shades) / number_of_distinct_colors_with_multiply_of_shades

    arr_by_shade_rows = linearly_distributed_nums.reshape(number_of_shades, number_of_distinct_colors_with_multiply_of_shades // number_of_shades)
    arr_by_shade_columns = arr_by_shade_rows.T

    number_of_partitions = arr_by_shade_columns.shape[0]
    nums_distributed_like_rising_saw = arr_by_shade_columns.reshape(-1)

    initial_cm = hsv(nums_distributed_like_rising_saw)

    lower_partitions_half = number_of_partitions // 2
    upper_partitions_half = number_of_partitions - lower_partitions_half

    lower_half = lower_partitions_half * number_of_shades
    for i in range(3):
        initial_cm[0:lower_half, i] *= np.arange(0.2, 1, 0.8/lower_half)

    for i in range(3):
        for j in range(upper_partitions_half):
            modifier = np.ones(number_of_shades) - initial_cm[lower_half + j * number_of_shades: lower_half + (j + 1) * number_of_shades, i]
            modifier = j * modifier / upper_partitions_half
            initial_cm[lower_half + j * number_of_shades: lower_half + (j + 1) * number_of_shades, i] += modifier

    return ListedColormap(initial_cm)
