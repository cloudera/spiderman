import os
import pandas as pd
import math
import numpy as np

from matplotlib.cm import hsv
from matplotlib.colors import ListedColormap

def _process_csv_file(file_path):
    """
    Processes a CSV file to count the number of unique questions.

    Args:
    file_path (str): The path to the CSV file.

    Returns:
    int: The number of unique questions in the CSV file.
    """
    try:
        df = pd.read_csv(file_path)
        unique_questions = df['question'].nunique()
        return unique_questions
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")
        return 0


def count_unique_questions(root_folder):
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
            unique_counts = []
            files = os.listdir(folder_path)
            
            for file in files:
                file_path = os.path.join(folder_path, file)
                
                if file_path.lower().endswith('.csv'):
                    unique_question_count = _process_csv_file(file_path)
                    unique_counts.append(unique_question_count)
            
            total_unique_count = sum(unique_counts)
            result_dict[folder] = total_unique_count
    
    return result_dict


def get_all_questions(root_folder):
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
            files = os.listdir(folder_path)
            
            for file in files:
                file_path = os.path.join(folder_path, file)
                
                if file_path.lower().endswith('.csv'):
                    try:
                        df = pd.read_csv(file_path)
                        for question in df['question'].unique():
                            data.append((folder, question))
                    except Exception as e:
                        print(f"Error processing {file_path}: {str(e)}")

    return pd.DataFrame(data, columns=['database', 'question'])


def generate_colormap(number_of_distinct_colors: int = 80):
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
