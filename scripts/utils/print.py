BAR_WIDTH = 70

def print_dict(d, label: str = ""):
    prefix = f"\n--- {label} " if label else ""
    print(prefix + "-" * (BAR_WIDTH - len(prefix)))

    for key, value in d.items():
        print(f"{key}: {value}")

    print("-" * BAR_WIDTH)
