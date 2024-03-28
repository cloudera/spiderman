from zipfile import ZipFile
from pydantic import BaseModel


class File(BaseModel):
    name: str
    path: str


class ZipReader:
    path: str
    zip: ZipFile

    def __init__(self, path: str):
        self.path = path

    def __enter__(self):
        self.zip = ZipFile(self.path)
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.zip.close()

    def list_sqlite_files_in(self, base_dir: str) -> list[File]:
        files = []
        file_list = self.zip.namelist()
        for file_path in file_list:
            if file_path.startswith(base_dir) and file_path.endswith('.sqlite'):
                parts = file_path.split("/")
                files.append(File(name=parts[2], path=file_path))
        return files

    def read_file(self, path: str) -> bytes:
        return self.zip.read(path)
