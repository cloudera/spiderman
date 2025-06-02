""""""
import shutil

from core.dataset import DatasetDir, QuerySplit
from utils.args import parse_dialect
from utils.iter import bar_iter
from core.factories import create_transpiler

def transpile_dbs(source_dataset: DatasetDir, target_dataset: DatasetDir):
  print("Transpiling databases...")

  transpiler = create_transpiler(target_dataset.dialect, pretty=True)

  target_dataset.clean()
  for db_name, _ in bar_iter(source_dataset.get_db_names(), "DB"):
          source_ddls = source_dataset.read_schema(db_name)

          target_ddls = []
          for ddl in source_ddls:
              transpiled_ddl = transpiler.transpile(ddl)
              target_ddls.append(transpiled_ddl)

          target_dataset.write_schema(db_name, target_ddls)

          # Copy data
          shutil.copytree(source_dataset.path_to_data_dir(db_name), target_dataset.path_to_data_dir(db_name), dirs_exist_ok=True)


def transpile_queries(source_dataset: DatasetDir, target_dataset: DatasetDir):
  print("Transpiling queries...")

  transpiler = create_transpiler(target_dataset.dialect, pretty=False)

  for split in [QuerySplit.TRAIN, QuerySplit.TEST]:
      queries_df = source_dataset.read_queries(split)

      queries_df['sql'] = queries_df['sql'].apply(transpiler.transpile)
      target_dataset.write_queries(split, queries_df.values.tolist())


if __name__ == "__main__":
  args = parse_dialect("Transpile MySQL schemas to another dialect")

  source_dataset = DatasetDir('mysql')
  target_dataset = DatasetDir(args.dialect)

  print(f"Transpiling from MySQL to {target_dataset.dialect}.")
  transpile_dbs(source_dataset, target_dataset)
  transpile_queries(source_dataset, target_dataset)
  print(f"Transpiling completed successfully.")
