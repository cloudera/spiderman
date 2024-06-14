import os
import pandas as pd

def count_unique_questions(root_folder):
    result_dict = {}
    
    # Function to process a CSV file and return the number of unique 'question' values
    def process_csv_file(file_path):
        try:
            df = pd.read_csv(file_path)
            unique_questions = df['question'].nunique()
            return unique_questions
        except Exception as e:
            print(f"Error processing {file_path}: {str(e)}")
            return 0
    
    # Iterate through each subfolder in the root folder
    for folder in os.listdir(root_folder):
        folder_path = os.path.join(root_folder, folder)
        
        # Check if the subfolder path is a directory
        if os.path.isdir(folder_path):
            unique_counts = []
            
            # List all files in the subfolder
            files = os.listdir(folder_path)
            
            # Iterate through files in the subfolder
            for file in files:
                file_path = os.path.join(folder_path, file)
                
                # Check if the file is a CSV file
                if file_path.lower().endswith('.csv'):
                    
                    # Process the CSV file
                    unique_question_count = process_csv_file(file_path)
                    unique_counts.append(unique_question_count)
            
            # Calculate total unique count for the folder
            total_unique_count = sum(unique_counts)
            
            # Store the result in the dictionary
            result_dict[folder] = total_unique_count
    
    return result_dict
