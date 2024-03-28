import csv
import os
import json


def create_missing_dir(file_path: str):
    output_directory = os.path.dirname(file_path)
    os.makedirs(output_directory, exist_ok=True)

def read_str(file_path: str) -> str:
    with open(file_path) as f:
        return f.read()

def write_str(file_path: str, data: str):
    create_missing_dir(file_path)

    with open(file_path, "w", newline='') as str_file:
        str_file.write(data)


def read_csv(file_path: str) -> list[list]:
    create_missing_dir(file_path)

    if not os.path.isfile(file_path):
        raise Exception(f"File not found - {file_path}")

    with open(file_path, mode='r', newline='', encoding='utf-8') as csv_file:
        csv_reader = csv.reader(csv_file)
        return list(csv_reader)


def write_csv(file_path: str, data: list[list], overwrite: bool = False):
    create_missing_dir(file_path)

    with open(file_path, 'w', newline='') as csv_file:
        csv_writer = csv.writer(csv_file)
        csv_writer.writerows(data)

def read_json_dict(file_path: str) -> dict:
    with open(file_path, "r") as file:
        return json.loads(file.read())
