#!/usr/bin/env python3
"""Apply wording fixes to ARB files AND the committed generated Dart in one step.

    python tools/dev/apply_l10n_fixes.py fixes.json      # {"ru": {"key": "new text"}, ...}

The generated files (app/lib/l10n/generated) are committed and CI fails if they are
stale, so editing only the .arb is not enough. This edits both; then run the CI task
`regen` (python tools/dev/gh.py dispatch regen) to let the real generator confirm the
result and fix line wrapping, and pull the commit it makes. Placeholders such as
{count} are handled (the generated code writes them as $count).
"""
import json
import re
import sys
from pathlib import Path

L10N = Path(__file__).resolve().parents[2] / "app" / "lib" / "l10n"


def _ph(s):
    return re.sub(r"\{(\w+)\}", lambda m: "\x00" + m.group(1) + "\x01", s)


def _unph(s):
    return re.sub(r"\x00(\w+)\x01", lambda m: "$" + m.group(1), s)


def dart_forms(s):
    s = _ph(s)
    single = "'" + s.replace("\\", "\\\\").replace("'", "\\'").replace("$", "\\$") + "'"
    double = '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("$", "\\$") + '"'
    return [_unph(single), _unph(double)]


def generated_file(loc):
    return L10N / "generated" / f"app_localizations_{loc.split('_')[0]}.dart"


def apply(loc, fixes):
    arb = L10N / f"app_{loc}.arb"
    data = json.loads(arb.read_text(encoding="utf8"))
    gen = generated_file(loc).read_text(encoding="utf8")
    for key, new in fixes.items():
        old = data[key]
        if old == new:
            continue
        done = False
        for a, b in zip(dart_forms(old), dart_forms(new)):
            if a in gen:
                if "'" in new and b.startswith("'"):
                    b = '"' + _unph(_ph(new).replace("\\", "\\\\").replace('"', '\\"').replace("$", "\\$")) + '"'
                gen = gen.replace(a, b)
                done = True
                break
        if not done:  # an identical string may already have been replaced
            done = any(b in gen for b in dart_forms(new))
        assert done, (loc, key, old)
        data[key] = new
    arb.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    generated_file(loc).write_text(gen, encoding="utf8")
    print(loc, "applied", len(fixes))


if __name__ == "__main__":
    for locale, fixes in json.loads(Path(sys.argv[1]).read_text(encoding="utf8")).items():
        apply(locale, fixes)
