from utils.print import print_dict

from core.dataset import get_stats


print("\n--- Dataset Stats ---")
stats = get_stats()
print_dict(stats)
