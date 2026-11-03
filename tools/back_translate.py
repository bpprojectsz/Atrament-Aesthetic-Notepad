#!/usr/bin/env python3
"""Back-translation screen for the app's translations.

Translates every non-English string back to English with a free, offline
model (Argos Translate) and compares it with the original English. Strings
whose back-translation shares little with the original are listed as
"worth a look". Machine translation is noisy, so this finds suspects; it
does not prove a translation right or wrong.

Usage (needs internet once, to download the models):
    pip install argostranslate
    python tools/back_translate.py shard <locale> [<locale> ...] --out DIR
    python tools/back_translate.py report DIR --out reports/back_translation.md
"""
import argparse
import json
import re
import sys
from pathlib import Path

ARB_DIR = Path(__file__).resolve().parent.parent / "app" / "lib" / "l10n"

# App locale -> Argos Translate language code. Languages with no model are
# listed in NO_MODEL and reported as not screened.
ARGOS = {
    "ar": "ar", "bg": "bg", "bn": "bn", "ca": "ca", "cs": "cs", "da": "da",
    "de": "de", "el": "el", "es": "es", "fa": "fa", "fi": "fi", "fil": "tl",
    "fr": "fr", "he": "he", "hi": "hi", "hu": "hu", "id": "id", "it": "it",
    "ja": "ja", "ko": "ko", "ms": "ms", "nb": "nb", "nl": "nl", "pl": "pl",
    "pt": "pb", "pt_PT": "pt", "ro": "ro", "ru": "ru", "sk": "sk", "sv": "sv",
    "sw": "sw", "th": "th", "tr": "tr", "uk": "uk", "ur": "ur", "vi": "vi",
    "zh": "zh", "zh_Hant": "zt",
}
NO_MODEL = ["gu", "mr", "ta", "te"]

# NLLB-200 (Meta) language codes. It covers every app language, including the
# ones Argos Translate has no model for.
NLLB = {
    "ar": "arb_Arab", "bg": "bul_Cyrl", "bn": "ben_Beng", "ca": "cat_Latn",
    "cs": "ces_Latn", "da": "dan_Latn", "de": "deu_Latn", "el": "ell_Grek",
    "es": "spa_Latn", "fa": "pes_Arab", "fi": "fin_Latn", "fil": "tgl_Latn",
    "fr": "fra_Latn", "gu": "guj_Gujr", "he": "heb_Hebr", "hi": "hin_Deva",
    "hu": "hun_Latn", "id": "ind_Latn", "it": "ita_Latn", "ja": "jpn_Jpan",
    "ko": "kor_Hang", "mr": "mar_Deva", "ms": "zsm_Latn", "nb": "nob_Latn",
    "nl": "nld_Latn", "pl": "pol_Latn", "pt": "por_Latn", "pt_PT": "por_Latn",
    "ro": "ron_Latn", "ru": "rus_Cyrl", "sk": "slk_Latn", "sv": "swe_Latn",
    "sw": "swh_Latn", "ta": "tam_Taml", "te": "tel_Telu", "th": "tha_Thai",
    "tr": "tur_Latn", "uk": "ukr_Cyrl", "ur": "urd_Arab", "vi": "vie_Latn",
    "zh": "zho_Hans", "zh_Hant": "zho_Hant",
}

PLACEHOLDER = re.compile(r"\{(\w+)\}")
WORD = re.compile(r"[a-z0-9]+")
STOP = {"the", "a", "an", "of", "to", "is", "are", "be", "this", "that", "and",
        "or", "in", "on", "it", "for", "your", "you", "please", "with", "as"}


def load(locale):
    d = json.loads((ARB_DIR / f"app_{locale}.arb").read_text(encoding="utf8"))
    return {k: v for k, v in d.items() if not k.startswith("@")}


def words(text):
    out = set()
    for w in WORD.findall(text.lower()):
        if w in STOP:
            continue
        # crude stemming so "deleted"/"delete"/"deleting" overlap
        for suffix in ("ing", "ed", "es", "s"):
            if len(w) > len(suffix) + 2 and w.endswith(suffix):
                w = w[: -len(suffix)]
                break
        out.add(w)
    return out


def score(original, back):
    a = words(PLACEHOLDER.sub(" ", original))
    b = words(PLACEHOLDER.sub(" ", back))
    if not a or not b:
        return 1.0 if not a and not b else 0.0
    common = len(a & b)
    if not common:
        return 0.0
    p, r = common / len(b), common / len(a)
    return 2 * p * r / (p + r)


def run_shard(locales, out_dir):
    import argostranslate.package as pkg
    import argostranslate.translate as tr

    out_dir.mkdir(parents=True, exist_ok=True)
    pkg.update_package_index()
    available = pkg.get_available_packages()
    english = load("en")
    for locale in locales:
        code = ARGOS[locale]
        match = next(
            (p for p in available if p.from_code == code and p.to_code == "en"),
            None,
        )
        if match is None:
            print(f"no model for {locale} ({code})", file=sys.stderr)
            (out_dir / f"{locale}.json").write_text(
                json.dumps({"locale": locale, "error": "no model"}), "utf8"
            )
            continue
        pkg.install_from_path(match.download())
        rows = []
        for key, value in load(locale).items():
            source = PLACEHOLDER.sub(lambda m: "X" + m.group(1).upper(), value)
            try:
                back = tr.translate(source, code, "en")
            except Exception as error:  # keep going; report the failure
                back = f"<error: {error}>"
            rows.append(
                {
                    "key": key,
                    "english": english[key],
                    "translated": value,
                    "back": back,
                    "score": round(score(english[key], back), 3),
                }
            )
        (out_dir / f"{locale}.json").write_text(
            json.dumps({"locale": locale, "rows": rows}, ensure_ascii=False, indent=1),
            "utf8",
        )
        mean = sum(r["score"] for r in rows) / len(rows)
        print(f"{locale}: mean overlap {mean:.2f}")


def run_shard_nllb(locales, out_dir):
    import torch
    from transformers import AutoModelForSeq2SeqLM, AutoTokenizer

    out_dir.mkdir(parents=True, exist_ok=True)
    name = "facebook/nllb-200-distilled-600M"
    model = AutoModelForSeq2SeqLM.from_pretrained(name).eval()
    english = load("en")
    for locale in locales:
        tok = AutoTokenizer.from_pretrained(name, src_lang=NLLB[locale])
        values = load(locale)
        keys = list(values)
        sources = [PLACEHOLDER.sub(lambda m: "X" + m.group(1).upper(), values[k]) for k in keys]
        backs = []
        for i in range(0, len(sources), 16):
            batch = tok(sources[i : i + 16], return_tensors="pt", padding=True)
            with torch.no_grad():
                out = model.generate(
                    **batch,
                    forced_bos_token_id=tok.convert_tokens_to_ids("eng_Latn"),
                    num_beams=4,
                    max_new_tokens=96,
                )
            backs += tok.batch_decode(out, skip_special_tokens=True)
        rows = [
            {
                "key": k,
                "english": english[k],
                "translated": values[k],
                "back": b,
                "score": round(score(english[k], b), 3),
            }
            for k, b in zip(keys, backs)
        ]
        (out_dir / f"{locale}.json").write_text(
            json.dumps({"locale": locale, "rows": rows}, ensure_ascii=False, indent=1),
            "utf8",
        )
        mean = sum(r["score"] for r in rows) / len(rows)
        print(f"{locale}: mean overlap {mean:.2f}")


def build_report(in_dir, out_path, worst):
    results = []
    for path in sorted(in_dir.rglob("*.json")):
        results.append(json.loads(path.read_text(encoding="utf8")))
    lines = ["# Back-translation screen", "",
             "Each non-English string was machine-translated back to English "
             "and compared with the original. Low overlap = worth a look. "
             "Machine translation paraphrases, so many flags are harmless.", ""]
    lines += ["| Locale | Mean overlap | Strings below 0.25 |", "|---|---|---|"]
    detail = []
    for r in sorted(results, key=lambda r: r["locale"]):
        if "rows" not in r:
            lines.append(f"| {r['locale']} | not screened ({r.get('error')}) | |")
            continue
        rows = r["rows"]
        mean = sum(x["score"] for x in rows) / len(rows)
        low = [x for x in rows if x["score"] < 0.25]
        lines.append(f"| {r['locale']} | {mean:.2f} | {len(low)} |")
        detail.append((r["locale"], sorted(rows, key=lambda x: x["score"])[:worst]))
    lines += ["", "Not screened (no free model): " + ", ".join(NO_MODEL), ""]
    for locale, rows in detail:
        lines += [f"## {locale}", ""]
        for x in rows:
            lines.append(f"- `{x['key']}` ({x['score']}): EN “{x['english']}” → "
                         f"“{x['translated']}” → back “{x['back']}”")
        lines.append("")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines), encoding="utf8")
    print(f"wrote {out_path}")


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("shard")
    s.add_argument("locales", nargs="+")
    s.add_argument("--out", required=True)
    s.add_argument("--engine", choices=["argos", "nllb"], default="argos")
    r = sub.add_parser("report")
    r.add_argument("indir")
    r.add_argument("--out", required=True)
    r.add_argument("--worst", type=int, default=12)
    a = ap.parse_args()
    if a.cmd == "shard":
        (run_shard_nllb if a.engine == "nllb" else run_shard)(a.locales, Path(a.out))
    else:
        build_report(Path(a.indir), Path(a.out), a.worst)


if __name__ == "__main__":
    main()
