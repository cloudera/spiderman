def print_dict(d, label: str = ""):
    if label:
        print(f"\n{label}")

    for key, value in d.items():
        print(f"{key}: {value}")
