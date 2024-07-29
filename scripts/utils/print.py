BAR_WIDTH = 70

def print_bar(label: str = ""):
    prefix = f"--- {label} " if label else ""
    print(prefix + "-" * (BAR_WIDTH - len(prefix)))
