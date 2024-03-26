from huggingface_hub import hf_hub_download

hf_hub_download(
    repo_id="Sreenath/spider",
    repo_type="dataset",
    filename="spider_v1.zip",
    local_dir="./source"
)
