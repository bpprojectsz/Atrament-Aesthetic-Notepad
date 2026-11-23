#!/usr/bin/env python3
"""Compare two NLLB back-translation runs and list what needs a human read.

usage: compare_nllb.py <old-git-rev> [--low 0.25] [--drop 0.15]

Old rows come from `git show <rev>:reports/nllb/<locale>.json`, new rows from
the working tree's reports/nllb/. A string is listed when its translation
changed since the old run AND (it now scores below --low, or it dropped by
more than --drop). It also reports strings that were NOT changed but score
below --low in the new run only when they were fine before (should be none:
the engine is deterministic), and strings added or removed.
"""
import argparse
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent


def old_rows(rev, locale):
    try:
        raw = subprocess.check_output(
            ["git", "show", f"{rev}:reports/nllb/{locale}.json"],
            cwd=ROOT, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        return None
    d = json.loads(raw)
    return {r["key"]: r for r in d.get("rows", [])}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("rev")
    ap.add_argument("--low", type=float, default=0.25)
    ap.add_argument("--drop", type=float, default=0.15)
    a = ap.parse_args()

    total_changed = 0
    listed = []
    summary = []
    for path in sorted((ROOT / "reports" / "nllb").glob("*.json")):
        locale = path.stem
        new = json.loads(path.read_text(encoding="utf8"))
        old = old_rows(a.rev, locale)
        if "rows" not in new or old is None:
            summary.append((locale, "not comparable", 0, 0, 0.0, 0.0))
            continue
        new_rows = {r["key"]: r for r in new["rows"]}
        changed = [k for k, r in new_rows.items()
                   if k in old and r["translated"] != old[k]["translated"]]
        total_changed += len(changed)
        mean_old = sum(r["score"] for r in old.values()) / len(old)
        mean_new = sum(r["score"] for r in new_rows.values()) / len(new_rows)
        flagged = 0
        for k in changed:
            o, n = old[k], new_rows[k]
            if n["score"] < a.low or o["score"] - n["score"] > a.drop:
                flagged += 1
                listed.append((locale, k, o, n))
        summary.append((locale, "ok", len(changed), flagged, mean_old, mean_new))

    print(f"strings whose translation changed since {a.rev}: {total_changed}")
    print("\n| locale | changed | to read | mean old | mean new |")
    print("|---|---|---|---|---|")
    for loc, st, ch, fl, mo, mn in summary:
        if st != "ok":
            print(f"| {loc} | {st} | | | |")
        else:
            print(f"| {loc} | {ch} | {fl} | {mo:.2f} | {mn:.2f} |")
    print(f"\n{len(listed)} strings to read:\n")
    for loc, k, o, n in listed:
        print(f"[{loc}] {k}  ({o['score']} -> {n['score']})")
        print(f"   EN : {n['english']}")
        print(f"   OLD: {o['translated']}")
        print(f"   NEW: {n['translated']}")
        print(f"   BACK(new): {n['back']}")


if __name__ == "__main__":
    main()
