import hashlib
import pandas as pd


SHA_LENGTH = 8


def df_to_sha(df: pd.DataFrame) -> str:
    return hashlib.sha256(df.to_csv(index=False).encode()).hexdigest()[:SHA_LENGTH]


def str_to_sha(s: str) -> str:
    return hashlib.sha256(s.encode()).hexdigest()[:SHA_LENGTH]
