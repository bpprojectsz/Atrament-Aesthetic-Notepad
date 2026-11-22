# Atrament — Handoff

> **New agent: start here.** Then read `docs/blueprint.md` (how the app works, file map) and `docs/decision.md` (why).
> Update this file and `decision.md` at the end of **every** batch (checklist at the bottom).

Last updated: after batch 18 (NLLB re-check done, device checklist written), on branch `languages`. Batches 12–15, 17 and 18 are built (see §6). The only commits since the last green CI touch docs and reports, not app code.
Current batch: **none in progress.** Next: batch 13 (consent failure). The owner answered all five open decisions (see §5).

## 1. Where things are

| Item | Value |
|---|---|
| Repository | https://github.com/bpprojectsz/Atrament-Aesthetic-Notepad (**public**) |
| Flutter app | `app/` |
| `main` | `660235c` — contains phases 0–11 (merged) |
| `languages` | see `git log` (batch 12 final = `ef8d44a`) — ~54 commits ahead of `main`, not merged |
| Old branch | `audit-fixes` (`84dec49`) — fully contained in `main`; can be deleted |
| Last green CI | run `44984663791` on `55d7674` (Compile Check, task `check`) — includes batches 12–15 and 17 |
| Owner's build | workflow **Build and Deploy** (manual) — never run, never edited |

**Access token.** A GitHub fine-grained token with write access + workflow scope exists. **Ask the owner for it in chat.** It is deliberately
**not** in this file or anywhere in the repo: the repo is public, a committed token would leak and GitHub would revoke it. Use it only via the
environment: `export GITHUB_TOKEN=...` (all scripts in `tools/dev/` read it from there). The owner has asked not to receive token-safety lectures (R5).

## 2. The environment you will work in

- The agent sandbox has **no Flutter/Dart SDK** and cannot download one. All analysis, tests and builds run in **GitHub Actions** (`Compile Check`).
- Network from the sandbox: GitHub, PyPI, npm and a few package hosts only. Translation-model hosts (Hugging Face, Argos) are blocked; GitHub's runners are not.
- A single tool call lasts **5 minutes**. Poll CI in short loops (`tools/dev/gh.py watch` stops after 280 s; call it again).
- **The sandbox filesystem resets without warning.** Everything is on GitHub; if `/tmp/at` vanishes, re-clone:
  `git clone -b languages https://x-access-token:$GITHUB_TOKEN@github.com/bpprojectsz/Atrament-Aesthetic-Notepad.git`
- CI log downloads are blocked; read failures from check-run **annotations** (`python tools/dev/gh.py why`). Annotation text is truncated (~1800 chars).
- The owner works from a phone (Termux). Give short, copy-pasteable commands; keep replies plain.

## 3. Standing rules (from the owner — see `decision.md` §A)

Audit before changing; smallest fix, no refactors · one batch at a time, CI green before the next · **never merge to `main` or run the APK build without the owner's go-ahead**
· say plainly what is unverified · no sub-agents for translation review; read every string against English and key name · don't lecture about the token ·
free tooling first · describe the real current state before proposing anything, and **never put "done" in a headline for something partly done** (this caused
a justified complaint once — list what remains first).

## 4. What is finished (one paragraph per area; details in `blueprint.md` §10)

Audit (86 findings) and phases 0–11: data safety, search, lock, ads/consent/IAP/review, appearance, handwriting, export, reminders, platform metadata,
typed localized errors, tests — merged to `main`. On `languages`: **43 language options** (41 requested + Traditional Chinese + European Portuguese) with
variant-aware locale handling, Thai/CJK/Arabic-script search, RTL for ar/fa/he/ur, editor labels for ta/te/mr/fil, a Quill variant fix and label overlay,
localized iOS permission prompts and Android notification channel, rendering/stress tests, machine back-translation (Argos + NLLB), a **full read of all 43 files**
with ~150 corrections recorded in `reviews/`, a Premium-screen scroll/overflow fix, and CI tooling (`regen`, stale check, SQLite workaround).

## 5. Owner decisions (all answered 21 Nov 2026; recorded as D-090…D-094)

1. **Ad triggers:** 15 counting points through one combined persisted counter; every 9th action makes an ad *pending*; 9-minute gap (D-096…D-098). **Built (batch 12).**
2. **Review prompt:** 20 saves, ≥3 distinct days of use, 60-day repeat, never on the same save as an interstitial nor within 10 minutes of one. **Built (batch 14).**
3. **Image-PDF memory:** measure first, then fix, then re-measure. **Built (batch 17).**
4. **`file_picker`:** KEEP; it stays on the outstanding ledger (batch 16 not scheduled).
5. **Machine re-check + device checklist:** after the batches below (batch 18).

## 6. Next batches (in order; each = code + tests + docs update + CI green)

| # | Batch | Scope | Done when |
|---|---|---|---|
| 12 | **BUILT, CI green** — Ad frequency | 5-minute spacing, timer persisted (guard against the clock moving backwards); triggers per decision 1; counters persisted if approved | `ads_rules_test` updated and green; blueprint §6.9 + decision.md updated |
| 13 | **BUILT, CI green** — Consent failure | One pure function `consentOutcome` (Google yes → request; Google no incl. declined → don't; error/timeout reading the answer → **allow** and retry once at the next foreground; failed update still reads Google's saved status; also returns whether to show "Privacy choices"). Unit-tested for every combination | tests green; the real SDK error paths remain **unverifiable without a device** — say so |
| 14 | **BUILT, CI green** — Review prompt | Rules from decision 2; store the set of days with a successful save; never within the proximity window of an interstitial | tests green |
| 15 | **BUILT, CI green** — Privacy page (`website/privacy.html`) | Ads via AdMob and Google's consent form (EEA/UK, some US states); declining may still show limited/non-personalized ads; if the form cannot be shown the app still asks Google and Google applies the last saved choice; where "Privacy choices" is; fonts are bundled (no downloads); OS backups; iOS tracking prompt; local reminders. Page is English only and **must be deployed by the owner**. Also update `store_submission/DATA_BACKING.md` (App Store privacy label / Play Data Safety answers) so it says the same thing; the owner submits the actual forms | text matches the shipped behaviour of batches 12–14 (write it last); DATA_BACKING.md consistent |
| 16 | *(not scheduled — owner kept `file_picker`, D-093)* | Remove `file_picker` only if the owner later asks | CI green; owner's next APK build is the real confirmation |
| 17 | **BUILT, CI green** — Image-PDF memory | Add a CI measurement (peak RSS for 10/50/100 pages), then render → compress → release one page at a time, then re-measure and report both numbers | before/after numbers recorded in decision.md |
| 18 | **BUILT** (machine re-check done, owner device test pending) — Verification re-run | `python tools/dev/gh.py dispatch back-translate-nllb`; read only the newly low-scoring strings against English; device checklist for the owner (Arabic, Urdu, Hindi, Tamil, Thai, Japanese, Traditional Chinese, German; first-launch language, picker, Settings, Premium, editor, export; Face ID prompt on iOS) | `reviews/` updated |
| 19 | Merge | Merge `languages` into `main` with a merge commit (keep history), re-run `check` on `main`, update docs. **Only then, and only on the owner's say-so,** trigger "Build and Deploy", report pass/fail and where the artifacts are | owner confirms |

**Backlog (not scheduled):** translate the 16 cover-color names (screen-reader labels); translate the website pages (privacy is legal text); translate daily verses (needs licensed Bible
translations — owner decision); decide the app name in ar/he/hi (transliterated vs "Atrament"); real AdMob IDs and the numeric App Store ID (`appStoreUrl`); Google's full SKAdNetwork list;
native-speaker review (use each `reviews/<locale>.md` list); Quill's remaining ~95 labels (unreachable in this app); scrollable taller handwriting page; dual typed+ink content.

## 7. Known risks and unverified items

- **Never run on a device.** Real glyph shapes (Urdu Nastaliq, Indic conjuncts, Thai), RTL layout on every screen, iOS prompts, ads/consent/IAP/biometrics/notifications are only simulated or unverified.
- **No native-speaker review** of ~6,000 strings. Biggest vocabulary risks: Swahili "dokezo" (note), Korean "노트북" (notebook = laptop), Thai "บันทึก" (save and note), Persian "دفترچه" (booklet/notebook),
  Tamil/Telugu/Marathi: no letter case so "Case sensitive" is meaningless; Hungarian/Malay/Swahili/Thai/Indic = lowest confidence.
- The iOS project edit (42 `InfoPlist.strings`, `project.pbxproj` variant group) is parsed and tested but **not built**; run the Codemagic iOS build before any release.
- If the APK build ever fails with `Hash of downloaded file …`, it is the SQLite download problem described in decision.md D-062, not the translations (not yet observed there).
- **Codemagic builds iOS with `flutter: stable`**, but `pubspec.yaml` pins Flutter to `>=3.47.0 <3.48.0`; if Codemagic's stable has moved past 3.47 the iOS build will refuse to resolve. Not verified (never run from here). Codemagic also runs `flutter test`, so the SQLite download problem could appear there too.
- `README.md` was stale (said 11 locales, "Flutter 3.24 exactly", a missing `FILE_MANIFEST.md`); corrected in the documentation batch, but check it again whenever versions or folders change.
- Consent: a read error now means "ads allowed" with one foreground retry (batch 13); the real UMP error paths are unverifiable without a device. Interstitials: batch 12 is built and tested with fakes only; the real ad show path is unverified on a device. An export or delete can be the 9th action, so an ad can follow the share sheet (owner accepted).
- Image-PDF export memory: ~10× lower than before in the test VM (D-111…D-114) but still not measured on a phone, and the new PDF writer is not tried in real phone viewers. The database never shrinks; deleted text can remain in free pages until a `VACUUM`.

## 8. Procedures

**Make a change.** Branch `languages` (or a new branch off it) → edit → `python tools/dev/gh.py dispatch check` → `watch` → `why` on failure → fix → commit with a message like `feat(area): what` /
`fix(area): what` → push. If the change touches an `.arb` file: use `tools/dev/apply_l10n_fixes.py` (edits ARB + committed generated Dart), push, `dispatch regen`, `git pull`, then `dispatch check`.
**Add a language/key:** add the key to every ARB (the generator needs the template `app_en.arb` plus each file), keep placeholders identical, use `’` not `'` in strings, then `regen`.
**Read a language:** `python tools/dev/show_translations.py <locale> --nllb` and record the result in `reviews/<locale>.md`.
**Docs:** `python tools/dev/gen_filemap.py --write` after any file is added/moved/deleted.

## 9. Pitfalls already paid for (don't repeat)

- Don't put tokens in any file. Don't use `cut -c` on non-ASCII text (it splits UTF-8; output becomes unreadable) — slice in Python.
- Every `.arb` change needs the matching committed generated Dart; CI fails on stale files. `regen` is the fix.
- New workflow files are only dispatchable once they exist on `main`; that is why all manual tasks live in `compile-check.yml` behind a `task` input.
- Test-font text is ~2× too wide (every glyph is a square); the rendering tests load Inter and scale other scripts. Don't "fix" overflow by shrinking real UI without checking with real widths.
- `package:intl` exports a `TextDirection` that shadows Flutter's; import `intl` with `show DateFormat`.
- A bare `'` in an ARB string with a placeholder can break the message format; use `’`.
- Quill chooses Chinese/Portuguese variants by **country code** and has no `nb`/ta/te/mr/fil: go through `quillLocaleFor` and `appQuillTranslations`.
- The machine back-translation is noisy for short labels; never accept or reject a string on it alone.
- A claim in a reply that was not checked in this session must be labelled as unverified (see rule R4).

## 10. Text to add to the project instructions

```
Before any work read docs/handoff.md, then docs/blueprint.md and docs/decision.md in the repo
bpprojectsz/Atrament-Aesthetic-Notepad (branch `languages` until merged). Ask the owner for the GitHub token; never write it to a file.
Work in small batches; run checks only in GitHub Actions (tools/dev/gh.py). Never merge to main or run the APK build without the owner's go-ahead.
Do not call work "done" if anything remains: list what is not done first. At the end of every batch update docs/decision.md (append) and
docs/handoff.md (state, next batches, risks) and regenerate the file map in docs/blueprint.md; commit them with the batch.
```

## 11. End-of-batch checklist

1. Tests added/updated; `check` green on the final commit (note the run id here in §1).
2. `decision.md`: append entries for every decision, pivot or revert (new IDs, don't edit old ones).
3. `blueprint.md`: update the feature text if behaviour changed; run `gen_filemap.py --write`; update §10 history.
4. `handoff.md`: update §1 (SHAs, CI run), §5–§7 (decisions, next batches, risks); update the "Last updated" line.
5. Report to the owner: what changed, what is still unverified, and the next step — in that order, plainly.
