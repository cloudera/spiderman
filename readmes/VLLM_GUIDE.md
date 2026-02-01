# Running models with VLLM

## Setup
```shell
huggingface-cli login
```

## Running the model

### defog/llama-3-sqlcoder-8b
```shell
uvx vllm serve defog/llama-3-sqlcoder-8b \
  --dtype bfloat16 \
  --max-num-seqs 32 \
  --api-key token-abc123
```

## Troubleshooting

### GPU Driver Issues
If you see `Failed to initialize NVML: Driver/library version mismatch`, the server needs a reboot or the NVIDIA kernel modules need to be reloaded. Contact your system administrator.
