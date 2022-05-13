#!/usr/bin/env python3
#
"""
Check ADR indexes for collisions. Exit with an error status if any are found.
"""
import sys
from pathlib import Path
from collections import Counter


def main() -> int:
    adr_dir = Path("./docs/adr")

    index_counter = Counter(
        filename.name.split("-")[0] for filename in adr_dir.iterdir()
    )
    if max(index_counter.values()) > 1:
        print(
            "Conflicts found on these indexes: "
            f"{[key for key in index_counter if index_counter[key] > 1]}"
        )
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())

# EOF
