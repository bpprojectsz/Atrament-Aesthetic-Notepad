# Atrament — Decision Log

Sequential record of decisions, pivots, upgrades and reverts, oldest first. **Append new entries at the bottom** (never rewrite
history; if a decision is reversed, add a new entry that says so). Format: `ID — decision — why — who/when`.
"Owner" is the project owner (works only from a phone; uses Termux). See `handoff.md` for current state.

## A. Ground rules set by the owner (apply to all work)

- **R1** Audit the real code before changing anything; report findings first. Make the smallest fix that solves each problem; no refactors.
- **R2** One batch = one commit set, CI-green before the next batch; nothing reaches `main` and no APK is built without the owner's go-ahead.
- **R3** The owner's existing APK workflow (`build_and_deploy.yml`) is never edited and never triggered unprompted.
- **R4** Say plainly what could not be verified. Do not claim "done" for anything that was not checked.
- **R5** Do not comment on token safety (owner works on a phone and has accepted the risk). *Practical consequence recorded in D-072: the token is still never written into the public repo.*
- **R6** No sub-agents / mass-agent approach for translation review. The comparison is done directly, one language at a time, reading **every** string against the English text and key name.
- **R7** Prefer free tooling. Anything that needs the Flutter SDK or a device runs in GitHub Actions or is handed to the owner.

## B. Audit and initial pivots

- **D-001** The project is a **Flutter/Dart app**, not Kotlin as the brief assumed (only a 4-line `MainActivity.kt`). The no-APK check became: `flutter analyze` + `flutter test` + a Kotlin compile. *Pivot.*
- **D-002** A full audit produced **86 findings** (4 critical: mode-toggle wipes content, lock-out after biometrics removed, missing iOS `GADApplicationIdentifier`, stale search results; many high/medium). Fixes were planned in 11 phases plus a safety-net phase 0.
- **D-003** Phase 0 (`compile-check.yml`) went straight to `main`; later phases went to branch `audit-fixes` and were merged with a merge commit after the owner approved (merge `079af69`, cleanup `660235c`).
- **D-004** The Kotlin compile step first failed because calling Gradle directly skipped a step Flutter runs; fixed by `flutter build apk --config-only` first. Side finding: real `minSdk` is **24** (Flutter 3.47 raises 21 → 24 for `flutter_local_notifications`).

## C. Owner decisions on the audit plan (D1–D9)

- **D1** Keep Google **test AdMob IDs**; add only Google's sample iOS app ID so iOS does not crash at launch.
- **D2** Leave the iOS Rate row/share link alone; use the **native review sheet** for the automatic prompt (iOS Rate row fails with a message until the real App Store ID is put in `appStoreUrl`).
- **D3** Keep **Android backup on**; fix the privacy wording instead of turning backup off.
- **D4** While the note lock is on: hide Home previews and require authentication for Share and Export.
- **D5** Toggling typed/handwriting uses a minimal fallback (never save an empty page over content); a dual-content format is a larger later change.
- **D6** Keep the post-export interstitial (a foreground-only guard was added, then removed again — see D-021).
- **D7** PDF text in scripts the standard fonts cannot draw is rendered as page **images** (bundling CJK fonts would add many MB).
- **D8** **Leave dead code** (`kjv.json` + lookup, unused verse/export helpers, scripture-size control). Still true; `file_picker` is another unused dependency (D-081).
- **D9** The daily reminder shows a real verse.

## D. Phases 1–11 (branch `audit-fixes`)

- **D-010** Phase 1 data safety: failed save keeps the user in the editor; saves serialised; autosave 2 s that never counts toward ads/review; corrupt content opens blank without overwriting; transactional notebook delete that also purges search-index rows.
- **D-011** **Revert (owner):** opening and closing a note *without editing* again saves, bumps the note to the top and counts as a save. Kept: autosave skips unchanged notes; unreadable content is never overwritten.
- **D-012** Phase 2 search: quote every token; debounce 250 ms + stale-result guard; CJK mid-word via `LIKE`; `ß`↔`ss` via DB v4.
- **D-013** Phase 3 lock: session unlock (re-lock after 60 s in background); authentication to toggle; device PIN counts as supported; AppCompat launch themes (needed by `local_auth` on Android ≤ 8).
- **D-014** Phase 4 ads: UMP consent before ads start; ads init after first frame; banner retry 30/60/120 s; cached ad-free flag; iOS never auto-restores purchases.
- **D-020** **Revert (owner):** three Phase 4 ad changes were put back exactly as they were — background saves, renames and moves count toward interstitials again; no foreground-only check; no 8-second load limit. **Kept:** autosave never counts (it would otherwise trigger an ad about every 18 s of typing); consent gate; banner retry; ad-free cache.
- **D-021** Consequence of D-020: the post-export interstitial has **no** foreground guard.
- **D-015** Phase 5 fonts **option B**: bundle static Regular/Bold/Italic Inter and Lora (≈1.0 MB), drop `google_fonts`; Parchment becomes a real theme (`appMode` extension); notes in notebooks use the global default paper; Recent = last 7 days; open notes directly from Home.
- **D-016** Phase 6 handwriting on raw pointer events; canvas width stored with strokes; segment-based eraser. A scrollable taller page is **not built**.
- **D-017** Phase 7 export: Unicode filenames + timestamp, handwriting exported as an image page, non-Latin text as image pages, prune old exports at start.
- **D-018** Phase 8 reminders: schedule the next 14 days with real verses; stable FNV-1a shuffled-cycle verse selection (verses change for everyone); pool deduplicated 559 → 492. D8 kept: no dead-code deletion, no scripture-size control.
- **D-019** Phase 9 metadata: iOS scene manifest, language lists, `ITSAppUsesNonExemptEncryption=false`; **no** app-level iOS privacy manifest (plugins ship their own; guessing declarations risked misstating privacy); 16 KB page-size check as a tool (libs were aligned).
- **D-022** Phase 10 typed issues replace English strings in providers/services; Phase 11 test gaps closed.

## E. Languages (branch `languages`)

- **D-030** Owner wants **all 41 languages** of a supplied list. Missing at the time: 30.
- **D-031** Owner decisions: Chinese gets **Simplified and Traditional (Taiwan wording)**; Portuguese gets **Brazilian (default) and European**; Norwegian is **Bokmål (`nb`)**.
- **D-032** Flutter's generator requires a base-language file when variants exist, so: `zh` = Simplified fallback + empty `zh_Hans` marker + full `zh_Hant`; `pt` = Brazilian + empty `pt_BR` marker + full `pt_PT`. The existing `zh`/`pt` files were audited first: `zh` was pure Simplified, `pt` pure Brazilian.
- **D-033** The locale code only used the language code, so variants could not work. Rewritten to save/resolve full tags (`zh_Hant`, `pt_PT`); old saved `zh`/`pt` upgrade to `zh_Hans`/`pt_BR`; picker hides bare fallbacks; date locale mapped to names Flutter has data for.
- **D-034** The generated l10n files are committed and the Flutter SDK is not available to the agent, so a CI task `regen` regenerates and commits them, and the normal check **fails if they are stale**.
- **D-035** Added in phases B–F (≈158 strings each, written by the agent): ru uk pl cs sk bg ro el · it nl sv da nb fi hu ca · tr id ms vi fil sw th · bn ta te mr gu · ur fa.
- **D-036** **Quill gap:** flutter_quill lacks `nb` (it uses `no`), ta, te, mr, fil. Added a wrapper delegate: `nb→no`; the app's own 106 editor labels for ta/te/mr/fil (owner chose this over waiting for Quill).
- **D-037** Thai (no spaces) uses the same substring search as Chinese/Japanese. Arabic-script spelling variants, vowel marks and digits are folded in the index (**DB v5**) so Persian users typing on an Arabic keyboard still match.
- **D-038** `rtlLanguageCodes` = {ar, fa, he, ur}; a test checks it against Flutter's own direction data.
- **D-039** Words that mean "Quran verse" in ar/fa/ur/tr/id/ms/sw (and ambiguous "promise/text" in bn/mr/gu/te) now say **"Bible verse"** in the daily-verse labels, because the app shows Bible verses.
- **D-040** The app name is transliterated in ar/he/hi but kept as "Atrament" in 38 other languages. **Left as is**, flagged for the owner.

## F. Verification approach

- **D-050** ML Kit was considered for back-translation and **rejected for the app** (adds a dependency and a model download). Back-translation runs only in CI.
- **D-051** The sandbox cannot reach translation-model hosts. Argos Translate ran on GitHub's runners (33 of 42 files worked; Spanish, Bengali, Filipino, Malay, Swahili failed; Gujarati, Marathi, Tamil, Telugu have no model). **NLLB-200** then covered all 42 files.
- **D-052** The machine check is weak on short labels (it returned nonsense for Turkish, Malay, Thai…), so it is a second signal only. The primary check is the **full human-style read** of every string beside the English and key name (`reviews/<locale>.md`, ~150 corrections).
- **D-053** Rendering tests draw Settings/Premium/Home in all 43 languages at 130 % text. They found a real bug (Premium could not scroll; plan label could not wrap) — fixed. Test-font widths are approximated for scripts without a bundled font.
- **D-054** Quill's label files were read for the 11 labels a user can actually reach (the app draws its own toolbar). Quill picks Chinese/Portuguese variants by country code; the app now maps `zh_Hant→zh_TW`, `zh_Hans→zh_CN`, `pt_BR/pt_PT→pt_BR`. An overlay corrects wrong/English labels (ar, bg, da, ja, ko, ms, nl, pl, sw, tr, ur, zh_Hant).
- **D-055** English source copy fixed in three strings (identity wording; "organize").

## G. Follow-ups after the language work

- **D-060** iOS Face ID and tracking prompts localized in 42 languages via `InfoPlist.strings` + `project.pbxproj` variant group (verified with a pbxproj parser; **not** built — needs Codemagic).
- **D-061** Android notification channel name = "Daily verse reminder" (translated); description is a new translated string; the channel is renamed whenever the language changes (works even with reminders off).
- **D-062** CI uses the runner's own SQLite for host tests: from 9 Nov 2026 the downloaded library copy failed its hash check on GitHub's runners (the published release is fine; cause unknown). This edit exists **only inside the CI job**.
- **D-063** `compile-check.yml` is the single manual workflow with a `task` input (`check`, `regen`, `back-translate`, `back-translate-nllb`) because a workflow file must exist on `main` to be dispatchable.

## H. Ad, consent and review decisions (current batch — decided, not yet built)

- **D-070** Interstitial spacing **5 minutes**; **no** session, daily or hourly cap; persist the timer across restarts. (An "8 per hour" idea was dropped: it conflicts with 5-minute spacing.)
- **D-071** Consent: if reading Google's answer errors, treat it as **ads allowed**; retry once when the app returns to the foreground; declined consent follows Google's answer; put the decision in one tested function (`consentOutcome`); update the privacy page to match.
- **D-072** **The access token is never written to the repository** (public repo → leak, and GitHub revokes leaked tokens automatically). The owner gives it to each new agent in chat; helper scripts read `GITHUB_TOKEN` from the environment.
- **D-073** Review prompt: native sheet after **20** successful saves on **≥3 distinct days of use**, repeating no sooner than **60 days**, never near an interstitial, Rate row always visible. *(Definition of "near" and the days-of-use counting are proposed in `handoff.md` and await confirmation.)*
- **D-074** Skipped as low value: Storage row in Settings, export-folder size cap, low-storage message. Debug log cap stays at 200.

## I. Documentation

- **D-080** `docs/blueprint.md` (master blueprint, file map generated by `tools/dev/gen_filemap.py`), `docs/decision.md` (this file) and `docs/handoff.md` are the project memory. They must be updated at the end of every batch.
- **D-081** `file_picker` is an unused dependency (only mentioned in two comments). Removal is recommended; awaiting the owner's yes.

## J. Owner answers to the open decisions (21 Nov 2026) and batch 12

- **D-090** Interstitial triggers: **all four count** (real save, note creation, export, notebook delete) through **one combined counter**; an ad is attempted on every **9th** action; the counter is **persisted** across restarts. Replaces the separate save/create counters of D-070's predecessor. Known trade-off (owner accepted): an export can be the 9th action, so an ad may follow the share sheet.
- **D-091** Review prompt confirmed (supersedes the "proposed" note on D-073): **20** successful saves, **≥3 distinct days of use** (a day counts if ≥1 successful save), repeat no sooner than **60 days**; "near an interstitial" = never on the same save as one and never within **10 minutes** of one.
- **D-092** Image-PDF memory: **measure in CI first, then fix, then re-measure.**
- **D-093** `file_picker` is **kept** for now and stays on the outstanding ledger (supersedes the "recommended removal" of D-081). Batch 16 is therefore not scheduled.
- **D-094** The machine re-check and the device checklist run **after** the ad/consent/review/privacy/memory batches.
- **D-095** Batch 12 built: `InterstitialService` keeps `interstitial_action_count` and `interstitial_last_shown_ms` in SharedPreferences. Gap = 5 minutes; a missing value or a clock that moved backwards counts as "elapsed" (so a wrong clock can never block ads for good). No session/daily/hourly cap (D-070). `lastShownAt()` is exposed for the review prompt (batch 14). Tests: `interstitial_policy_test.dart` (gap rule, combined counter, persistence across a simulated restart); a test hook replaces the real show step because the ads/purchase plugins do not exist in unit tests. CI green (run 44882045369, commit 52e74d2). The real show path is still **unverified on a device**.
- **D-096** (supersedes the gap in D-070/D-095) Minimum gap between interstitials is **9 minutes**.
- **D-097** **Pending ad.** After 9 counted actions an ad becomes *pending* (persisted: `interstitial_pending`) and is shown on the first counting action at which the gap has passed; the counter pauses while pending, and resets only when an ad is actually shown. Nothing is wasted. A failed attempt (offline, no fill, SDK off) is retried no sooner than 60 s later (memory only).
- **D-098** Home banner **removed** (banner now on the notebook screen and Settings only). Counting points added by the owner: Home new-note button, notebook creation (provider, so it also counts when created from the move sheet), Edit menu item, Share as text, note delete (provider, covers the menu, the icon and the swipe), Settings return, notebook-screen return to Home, paper style chosen in the editor. Unchanged: editor exit, backgrounding in the editor, rename, move, export, notebook delete. One visit can count several times (e.g. new note + exit); accepted.
- **D-099** CI green (run 44886070440, commit ef8d44a). Unverified: the real ad show path, and how often ads appear in real use.
- **D-100** Batch 13 built (implements D-071): `consentOutcome` in `consent_service.dart` is the single decision. Google yes → request ads; Google no (including after a decline) → no ads, never retried; an **error or timeout reading Google's answer → ads allowed** and **one** retry at the next foreground (a second failure keeps ads allowed, no further retry); a failed consent-info update or form still reads Google's saved status; an unreadable "privacy options" status keeps the Settings row as it was. Reads time out after 10 s.
- **D-101** `AdMobService` now keeps a `_consentBlocked` flag, so a later answer of "no" (declined at the retry, or consent withdrawn through Privacy choices) stops ad requests even though the SDK was already started. Before, withdrawal only affected a not-yet-started SDK. The retry runs from the app's resume handler in `main.dart`.
- **D-102** Compliance note: treating a read error as "ads allowed" follows Google's published guidance as stated by the owner; it is not legal advice. For EEA/UK users the SDK limits what is served. Unverified on a device: the real UMP error paths cannot be exercised in tests.

