#!/usr/bin/env python3
"""Print every string of one language next to the English text and key name.

    python tools/dev/show_translations.py ru            # all 158 strings
    python tools/dev/show_translations.py ru 0 80       # a slice
    python tools/dev/show_translations.py ta --nllb     # add the NLLB back-translation

Reading a language this way (key | English | translation | machine back-translation)
is how every language was reviewed; see reviews/<locale>.md for the records.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
L10N = ROOT / "app" / "lib" / "l10n"


def main():
    loc = sys.argv[1]
    nums = [a for a in sys.argv[2:] if a.isdigit()]
    lo, hi = (int(nums[0]), int(nums[1])) if len(nums) == 2 else (0, 158)
    en = json.loads((L10N / "app_en.arb").read_text(encoding="utf8"))
    tr = json.loads((L10N / f"app_{loc}.arb").read_text(encoding="utf8"))
    keys = [k for k in en if not k.startswith("@")]
    back = {}
    if "--nllb" in sys.argv:
        p = ROOT / "reports" / "nllb" / f"{loc}.json"
        back = {r["key"]: r["back"] for r in json.loads(p.read_text(encoding="utf8"))["rows"]}
    for i, k in enumerate(keys[lo:hi], start=lo + 1):
        e = en[k] if len(en[k]) <= 40 else en[k][:38] + "…"
        extra = f"|«{back[k][:46]}»" if k in back else ""
        print(f"{i} {k}|{e}|{tr.get(k, '<<MISSING>>')}{extra}")


if __name__ == "__main__":
    main()
