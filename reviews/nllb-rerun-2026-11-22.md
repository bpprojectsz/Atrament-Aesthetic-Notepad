# NLLB re-check of the corrected strings (batch 18, 2026-11-22)

Run: CI task `back-translate-nllb`, run 44986249585, on commit `9929898` (all corrections included). All 42 language files were screened by the engine.
Compared with the previous run (commit `827a02d`) using `python tools/dev/compare_nllb.py 827a02d`.

strings whose translation changed since 827a02d: 178.

## What was checked

1. Every string whose translation changed since the previous run (178 of about 6,600) was compared with its old score. 56 were listed (new score below 0.25, or a drop of more than 0.15). **All 56 were read against the English text.**
2. Keys added since the previous run: one, `notificationChannelDescription` (42 translations). 38 score 0.35 or higher. The four lower ones (bn, mr, th, zh_Hant) were read against "Your optional daily Bible verse reminder".
3. Mean overlap per language changed by at most 0.03 (see the table).

## Result

**No new real error was found.** Every flagged string was a machine-translation artefact or an intentional change. Verdicts by kind:

- **Quotes added around the feature name** ("Remove Ads" in the "you already have it" message: da, es, he, pl, sv, th). The back-translation paraphrases the quoted name away. Intentional (batch review).
- **"Debug log" in Arabic** (`سجل تصحيح الأخطاء`): the standard term for debugging; the old wording could read as a proof-reading log. Correct.
- **Notebook ruling in Russian and Ukrainian** (`В линейку / В клетку / В точку`, `У лінійку / У клітинку / У крапку`): the idiomatic terms for ruled, squared and dotted notebooks. The literal back-translation ("in the line", "in the cage") is expected. Correct.
- **Telugu** `గీతలతో / చుక్కలతో / గడులతో` (with lines / dots / squares): correct; "songs", "drops" and "holes" in the back-translation are alternate senses of the same words.
- **Verse-label disambiguation** ("Bible" added: ar, fa, gu, te, tr, ur, ja): intentional, so that the word does not read as a Quran verse. Correct.
- **Heading versus header** (ca, ms, pl, sw): the two labels now differ ("Títol de secció" / "Nagłówek strony" and so on). Correct.
- **Typographic apostrophe** (fr `L’app`, `Conditions d’utilisation`): the engine drops the apostrophe, so the back-translation reads "Lapp". The French is correct.
- **Hindi share message**: the back-translation is a hallucination triggered by the em dash. The Hindi is correct.
- **Parchment** (ja `羊皮紙`, sw `Karatasi ya ngozi`): correct; the Swahili is understandable but literally "paper of skin" (see risks).

## Open risks for a native speaker (unchanged or newly noted)

- Swahili `Karatasi ya ngozi` (parchment) is literal and may read as "leather-like paper"; `Italiki` is the usual loanword but the engine reads it as "Italian".
- Tamil `முடக்கம்` for "Off" (also "disabled/frozen") and `அடிப்பகுதி` for "Footer".
- Persian `نقطه‌ای` (dotted) for "Dot Grid" versus the stationery term `نقطه‌چین`.
- Traditional Chinese `你可選用的每日經文提醒` is correct but a little stiff.

## Limits

- Only changed and new strings were re-screened; unchanged strings keep their earlier score (the engine is deterministic) and their earlier human read.
- The engine is noisy on short labels and cannot prove a translation right. It finds large mismatches only.
- **Not screened:** the iOS permission prompts (Face ID, tracking) in `InfoPlist.strings` (42 languages, 2 texts each) are not in the ARB files, so this tool never saw them. They were checked only by my own read.
- No native-speaker review and no device test.

## Per-language summary

| locale | changed | to read | mean old | mean new |
|---|---|---|---|---|
| ar | 12 | 7 | 0.51 | 0.50 |
| bg | 1 | 0 | 0.46 | 0.47 |
| bn | 6 | 0 | 0.63 | 0.64 |
| ca | 3 | 1 | 0.50 | 0.51 |
| cs | 0 | 0 | 0.48 | 0.49 |
| da | 3 | 1 | 0.52 | 0.53 |
| de | 5 | 1 | 0.53 | 0.54 |
| el | 1 | 0 | 0.44 | 0.44 |
| es | 2 | 2 | 0.55 | 0.54 |
| fa | 5 | 2 | 0.47 | 0.47 |
| fi | 2 | 1 | 0.47 | 0.47 |
| fil | 9 | 0 | 0.70 | 0.73 |
| fr | 15 | 3 | 0.51 | 0.52 |
| gu | 6 | 1 | 0.68 | 0.70 |
| he | 2 | 2 | 0.44 | 0.44 |
| hi | 15 | 2 | 0.74 | 0.74 |
| hu | 2 | 0 | 0.43 | 0.43 |
| id | 5 | 0 | 0.54 | 0.55 |
| it | 2 | 0 | 0.53 | 0.53 |
| ja | 5 | 2 | 0.53 | 0.53 |
| ko | 0 | 0 | 0.41 | 0.41 |
| mr | 4 | 0 | 0.65 | 0.65 |
| ms | 5 | 1 | 0.50 | 0.51 |
| nb | 3 | 0 | 0.56 | 0.57 |
| nl | 1 | 0 | 0.54 | 0.55 |
| pl | 4 | 3 | 0.51 | 0.51 |
| pt | 3 | 1 | 0.54 | 0.55 |
| pt_PT | 1 | 0 | 0.50 | 0.51 |
| ro | 1 | 0 | 0.48 | 0.49 |
| ru | 4 | 4 | 0.54 | 0.54 |
| sk | 0 | 0 | 0.46 | 0.47 |
| sv | 2 | 1 | 0.54 | 0.54 |
| sw | 10 | 6 | 0.44 | 0.45 |
| ta | 3 | 3 | 0.60 | 0.61 |
| te | 6 | 4 | 0.67 | 0.68 |
| th | 5 | 1 | 0.37 | 0.37 |
| tr | 5 | 2 | 0.58 | 0.58 |
| uk | 4 | 4 | 0.49 | 0.49 |
| ur | 15 | 1 | 0.64 | 0.65 |
| vi | 1 | 0 | 0.43 | 0.43 |
| zh | 0 | 0 | 0.50 | 0.50 |
| zh_Hant | 0 | 0 | 0.40 | 0.40 |
