from utils.print import print_dict
from core.dataset import get_stats


stats = get_stats()
print_dict(stats, label="Dataset Stats")
