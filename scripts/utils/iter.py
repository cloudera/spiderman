from typing import TypeVar
from alive_progress import alive_bar


I = TypeVar('I')
def bar_iter(items: list[I], label: str = ""):
    """A generator function that iterates over a list of items with a progress bar."""

    if not items:
        raise ValueError("No items found.")

    with alive_bar(len(items)) as bar:
        for item in items:
            bar.text(f">> {label}: {item}")
            yield item, bar
            bar()
