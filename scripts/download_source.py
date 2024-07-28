from huggingface_hub import hf_hub_download
from core.paths import SOURCE_DIR


hf_hub_download(
    repo_id="Sreenath/spider",
    repo_type="dataset",
    filename="spider_v1.zip",
    local_dir=SOURCE_DIR
)

print(f"File downloaded into '{SOURCE_DIR}' directory")
