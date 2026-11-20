# Atrament — Master Blueprint

> **Read order for a new agent:** `docs/handoff.md` (where things stand, what to do next) →
> this file (what the app is and how every piece connects) → `docs/decision.md` (why it is the way it is).
> Keep all three current: see "Keeping these docs current" in `handoff.md`.

Last verified against the code: branch `languages`, commit `c3da42e` (CI run 42589664459 green).

---

## 1. Product vision

Atrament is a premium, distraction-free **private notepad** for Android and iOS, built in Flutter.
It offers paper textures (lined, dot grid, grid, blank, cream, parchment, vellum), typed rich text
and freehand handwriting, notebooks, search, an optional biometric lock, export to text/PDF, and a
**daily Bible verse** (King James text) shown on the note or sent as a daily reminder.

Principles that shape every decision:
- **Private by default.** Notes live in a local SQLite database. No accounts, no sync, no servers.
- **Free with one small banner ad.** A one-time purchase ("Remove Ads") removes ads; it unlocks nothing else.
- **43 language options** (41 requested languages + Traditional Chinese and European Portuguese), including
  right-to-left languages. The UI follows the system language on first install and can be overridden manually.
- **Calm.** No onboarding, no nagging; review and share prompts are rate-limited.

## 2. Tech stack

| Area | Choice |
|---|---|
| Framework | Flutter pinned to `>=3.47.0 <3.48.0` in `pubspec.yaml`, Dart `>=3.0 <4.0`; Android `minSdk` shown as 21 in the repo but Flutter 3.47 raises it to 24 in real builds (`flutter_local_notifications` needs 24) |
| State | Plain provider classes that each hold `ValueNotifier`s (screens listen with `ValueListenableBuilder`/`ListenableBuilder`); the `provider` package is used only to pass objects down the widget tree |
| Storage | `sqflite` / SQLite (FTS5 virtual table for search), `shared_preferences` for settings |
| Rich text | `flutter_quill` 11.6 (editing surface only; the toolbar is the app's own) |
| Ads | `google_mobile_ads` 9.1 (banner + interstitial, UMP consent) — **Google test IDs** are in use (owner decision) |
| Purchases | `in_app_purchase` (Play Billing / StoreKit) |
| Lock | `local_auth` |
| Notifications | `flutter_local_notifications` (+ timezone) |
| Export / share | `pdf`, `share_plus`, `path_provider` |
| Review | `in_app_review` |
| Localization | `flutter_localizations`, `intl`, ARB files + `gen_l10n` (generated files are committed) |
| Fonts | Inter, Lora, Merriweather bundled as assets (no runtime font downloads) |
| CI | GitHub Actions (two manual workflows, see §8) |

## 3. Repository layout

```
app/                    the Flutter app
  lib/                  source (see §12 file map)
  lib/l10n/             ARB translation files (43) + generated Dart (committed)
  test/                 ~35 test files (see §9)
  assets/               fonts, json (daily_verses.json, kjv.json), licences
  android/ ios/         platform projects (see §7)
website/                static pages: index, privacy, terms, support (English only)
store_submission/       store listing text (ASO_METADATA.md), privacy-label / Data Safety answers (DATA_BACKING.md), screenshot plan, icon and feature graphic
codemagic.yaml          iOS build on Codemagic (analyze, tests, release IPA, upload to TestFlight)
tools/                  check_pbxproj.sh, check_native_alignment.py
tools/dev/              helper scripts for agents (CI driver, translation viewer, fix applier, file-map generator)
reviews/                one review record per language (+ English source + Quill labels)
reports/                back-translation reports (Argos, NLLB) and per-language NLLB data
docs/                   blueprint.md, decision.md, handoff.md
.github/workflows/      build_and_deploy.yml (owner's APK/AAB build), compile-check.yml (manual checks)
```

## 4. Architecture and start-up sequence

Layers (dependencies point downward only): **screens → widgets → providers → services → platform wrappers → models/utils**.

`lib/main.dart` start-up, in order:
1. Initialise bindings; start non-blocking work: notification service, `ExportService.pruneOldExports()`
   (deletes exported files older than 1 day), install-date record, `AppLock.init()`.
2. `runApp(AtramentApp)`. After the **first frame**, `AdMobService.initialize()` (which runs the consent flow first).
3. `AtramentApp` creates providers: `LocaleProvider`, `ThemeProvider`, `SubscriptionProvider`, `VerseProvider`
   (plus `NoteProvider`/`NotebookProvider` per screen), and registers a lifecycle observer.
4. On start, on locale change and when the app returns to the foreground, `_refreshReminders()` runs:
   it names the notification channel in the user's language and re-schedules the next 14 days of verse reminders.
5. `MaterialApp` is built with the app's localization delegates, `localeListResolutionCallback: resolveAppLocale`,
   a `locale` override when the user picked a language, the theme from `AppTheme`, and an RTL-aware builder.

## 5. Data model and storage

**SQLite (`atrament.db`, schema version 5)** — `lib/core/services/local_storage.dart`

```sql
notebooks(id TEXT PK, name, coverColor INTEGER, paperStyleDefault, sortOrder INTEGER, createdAt, modifiedAt)
notes(id TEXT PK, title, content, notebookId -> notebooks(id) ON DELETE CASCADE, paperStyle,
      createdAt, modifiedAt, verseReference)
notes_fts USING fts5(id UNINDEXED, title, plainText, tokenize='porter unicode61')
```
Version history: **v2** added `notebooks.modifiedAt`; **v3** rebuilt `notes` so `notebookId` can be empty (notes outside any notebook)
and re-created its index; **v4** folds `ß→ss` in the search index; **v5** folds Arabic-script spellings (see Search). Opening the DB
also purges orphaned search rows.

**Note content (`notes.content`)** is a JSON string in one of two shapes:
- typed text: a Quill Delta array;
- handwriting: `{"type":"handwriting","strokes":[...],"width":<canvas width>}` (width lets ink rescale on other screens).

**Preferences (`shared_preferences`)** keys live in `lib/core/utils/constants.dart` (`pref*`): theme mode, default paper,
font, verse display mode, reminder on/off/time, biometric lock, locale tag (e.g. `zh_Hant`), install date, save/export
counters, last review prompt, ad-free cache, and so on.

## 6. Features: how each works and which files own it

### 6.1 Notes and notebooks
`NoteProvider` / `NotebookProvider` wrap `LocalStorage` and expose lists, search results and a typed storage-issue
(`StorageIssue`) that screens turn into localized text. Home (`home_screen.dart`) shows All / Notebooks / Recent
(last 7 days). Deleting a notebook is one transaction that removes its notes and their search rows.
Failed storage calls never throw to the UI; they set an issue shown as a dismissible banner.

### 6.2 Editor and saving (`screens/note_editor_screen.dart`)
- Typed mode uses `QuillEditor.basic`; the toolbar is the app's own (`widgets/note_toolbar.dart`, `widgets/pen_toolbar.dart`).
- **Saves are serialised** (a second save waits for the first, then saves a fresh snapshot).
- **Autosave** runs 2 s after the last change and never counts toward ads or review; it skips unchanged notes.
- **Leaving the editor** (Back or app to background) always saves and bumps the note to the top; a **failed save keeps you
  on screen** with a message, and a second Back leaves.
- Switching typed/handwriting never wipes the other mode's content; unreadable content opens blank without overwriting the original.

### 6.3 Handwriting (`widgets/handwriting_canvas.dart`)
Raw pointer events (a stroke starts exactly where the finger lands; a tap draws a dot; only the first pointer draws, so palms are
ignored). Strokes are saved with the canvas width and rescaled on load. The eraser tests distance to line **segments**.

### 6.4 Paper, themes, fonts
`paper_style_model.dart`, `paper_background.dart`, `paper_selector.dart`. `ThemeProvider` holds light/dark/parchment/system;
an `AppThemeMode` theme extension (`context.appMode`) lets every widget read the real mode (Parchment looks different from Light).
Fonts: Inter and Lora are bundled (Latin/Cyrillic/Vietnamese subsets); Merriweather renders verses.

### 6.5 Search (`LocalStorage.searchNotes`, `note_provider.dart`)
- Each token is quoted for FTS5 (`"token"*`) so punctuation and operator words (`NOT`, `C++`, `co-op`) never break a query.
- **Folding** (`foldForSearch`, single table `_searchFold`): `ß→ss`; Arabic/Farsi yeh and kaf variants; Arabic vowel marks and tatweel
  removed; Arabic-Indic and Persian digits → ASCII. The same table builds the SQL used by the v4/v5 migrations.
- Queries containing **Chinese, Japanese or Thai** characters use a substring `LIKE` search (these scripts have no spaces).
- The provider debounces typing (250 ms) and ignores stale results; clearing the box restores all notes.

### 6.6 Note lock (`core/services/app_lock.dart`, `widgets/lock_gate.dart`, `platform/biometric_service.dart`)
One unlock covers a session; the app re-locks after 60 s in the background. While locked, Home hides previews and Share/Export ask to
unlock. Turning the lock on/off requires authentication. If the device can no longer authenticate, the lock turns itself off with a message.
It is a screen lock, not encryption (the database is not encrypted).

### 6.7 Export and share (`core/services/export_service.dart`, `core/services/export_page_renderer.dart`, `core/utils/export_helper.dart`, `platform/share_service.dart`)
`.txt` and `.pdf`. Filenames keep letters/digits of every script, are capped, and carry a timestamp (no overwrites). Text the standard PDF
fonts cannot draw (CJK, Arabic, Hebrew, Indic, Thai, Cyrillic, Greek, emoji…) and handwriting notes are drawn page by page with Flutter's
own text layout at 1.5× scale **into memory, all pages at once**, then placed in the PDF (memory grows with page count — see handoff). Files go to the
temp folder; `pruneOldExports` removes those older than a day at app start.

### 6.8 Daily verse and reminders (`core/services/verse_service.dart`, `core/providers/verse_provider.dart`, `core/services/reminder_scheduler.dart`, `platform/notification_service.dart`)
`assets/json/daily_verses.json` (492 verses, English KJV) is the pool. Selection is a stable shuffled cycle (FNV-1a), never repeating the
previous day. Display modes: watermark / header / footer / off. Reminders: the next 14 days are scheduled, each with that day's verse,
topped up on launch, on foreground (at most every 30 min) and on language change. The Android channel name/description is localized at runtime.
(`kjv.json`, 4.7 MB, is unused dead code — owner chose to leave it.)

### 6.9 Ads and consent (`platform/admob_service.dart`, `platform/consent_service.dart`, `platform/interstitial_service.dart`, `widgets/banner_ad_widget.dart`)
- Consent (Google UMP) runs before the Mobile Ads SDK starts; the SDK starts only if Google's `canRequestAds` says yes; a "Privacy choices"
  row appears in Settings where required. An error reading Google's answer currently means "no ads" (planned to change: see handoff).
- Banner on list screens, retried at 30/60/120 s after a failed load. Paying users get no banner (the ad-free flag is cached so there is no flash).
- Interstitial: every 9th explicit editor exit and every 9th note creation, **plus after every export and every notebook delete**, subject only to a
  30-second cooldown. All counters and the cooldown are **in memory** (reset on restart). Autosave never counts. (Planned to change: see handoff.)
- AdMob IDs are Google's test IDs by owner decision.

### 6.10 Premium (`core/services/iap_service.dart`, `core/providers/subscription_provider.dart`, `screens/premium_screen.dart`)
A one-time "Remove Ads" product. The provider emits typed purchase results (success, failed, nothing to restore); the Premium screen and Settings
show localized messages. An ad-free flag is cached so paying users never see an ad flash; on iOS restore is user-initiated only.

### 6.11 Review and share prompts (`core/services/engagement_service.dart`)
Native review sheet (`in_app_review`) after **20** successful saves and **≥5 days** since install, with a **30-day** cooldown between attempts.
Settings has an always-visible Rate row (opens the store listing; on iOS it needs the real App Store ID — placeholder `id0000000000` today).

### 6.12 Localization (the largest subsystem)
- **Files:** `app/lib/l10n/app_<locale>.arb` — template `en` (158 keys + `notificationChannelDescription`), 42 translations. Chinese: base `zh` = Simplified
  fallback, `zh_Hans` (empty marker), `zh_Hant` (Taiwan wording). Portuguese: base `pt` = Brazilian, `pt_BR` (empty marker), `pt_PT` (European).
  Generated Dart is committed; CI fails if stale; the `regen` task regenerates it.
- **Resolution:** `locale_utils.dart` — `resolveAppLocale` (device list → app language; Chinese by script/region; Portuguese regions;
  legacy codes `iw in no nn tl`), `localeTag`/`localeFromTag` (saved choice, e.g. `zh_Hant`), `migrateLegacyLocale`, `pickerLocales`, `dateLocaleName`,
  `rtlLanguageCodes` = {ar, fa, he, ur}. First install follows the system; a manual choice (picker) overrides and survives restarts.
- **Editor labels:** `app_localization_setup.dart` + `quill_extra_localizations.dart` — wrapper delegate: the app's own 106 labels for ta/te/mr/fil
  (Quill has none), Quill's own for other languages (variant chosen by country code: zh_Hant→zh_TW, zh_Hans→zh_CN, pt→pt_BR, nb→no), plus an overlay
  that corrects labels Quill gets wrong or leaves in English.
- **Platform:** Android `res/xml/locales_config.xml`; iOS `CFBundleLocalizations` + 42 `*.lproj/InfoPlist.strings` (Face ID and tracking prompts) wired into
  `project.pbxproj` as a variant group. Checked by `platform_metadata_test.dart` and `ios_permission_strings_test.dart`.
- **Quality record:** every language was read in full against English and key names (`reviews/*.md`, ~150 corrections); machine back-translation
  reports in `reports/`; open vocabulary risks are listed in each review file.

### 6.13 Diagnostics
`core/utils/error_handler.dart` + `platform/debug_log_service.dart`: errors are recorded (capped at 200 entries) and can be shared from Settings as a text report.
User-facing errors are typed enums (`StorageIssue` and friends in `core/utils/user_issues.dart`) mapped to localized text by `widgets/user_issue_text.dart`.

## 7. Platform configuration

- **Android:** `AndroidManifest.xml` (AdMob test app ID, per-app language via `localeConfig`, backup left on by owner decision), AppCompat launch themes
  (needed by `local_auth` on older Android), ProGuard rules, notification small icon (monochrome).
- **iOS:** `Info.plist` (scene manifest, `GADApplicationIdentifier` = Google's sample, one SKAdNetwork entry, `ITSAppUsesNonExemptEncryption=false`,
  localizations, English permission texts), `Runner.xcodeproj` (guarded by `tools/check_pbxproj.sh`). iOS builds run on **Codemagic**, not here.

## 8. CI, build and tooling

| Workflow | Trigger | What it does |
|---|---|---|
| `build_and_deploy.yml` ("Build and Deploy") | manual only | Owner's real build: analyze, tests, signed AAB + APK. Needs secrets `ANDROID_KEYSTORE_BASE64`, keystore/key passwords and alias. **Never edited; never run without the owner's go-ahead.** |
| `compile-check.yml` ("Compile Check") | manual, `task` input | `check` (default): stale-localization check → `flutter analyze` → tests (uses the runner's SQLite, see decision.md) → Kotlin compile (no APK) → resource link → 16 KB check → Android lint. `regen`: regenerate `lib/l10n/generated` and commit. `back-translate` (Argos) and `back-translate-nllb`: write reports into `reports/`. |
| `codemagic.yaml` ("Atrament iOS Build") | on Codemagic | Mac mini M2, `flutter: stable`, `xcode: latest`: `flutter pub get`, analyze, tests, CocoaPods, `flutter build ipa --release`, upload to **TestFlight** (App Store submission is off). Needs the `app_store_credentials` group. **Not controlled from this repo's CI and never run by the agent.** |

`tools/dev/` (no secrets inside; token comes from `GITHUB_TOKEN`): `gh.py` (dispatch/watch/why), `show_translations.py`, `apply_l10n_fixes.py`, `gen_filemap.py`.

## 9. Tests (what guards what)

`translation_files_test` (every ARB: keys, placeholders, no leftover English) · `language_stress_test` (all 43: delegates, resolution, manual choice, direction) ·
`language_rendering_test` (Settings/Premium/Home overflow in every language at 130% text) · `locale_variants_test` · `platform_metadata_test` ·
`ios_permission_strings_test` · `phase5_theme_and_l10n_test` (Quill delegate/overlay) · `local_storage_test` (CRUD, v2→v5 migrations, search incl. CJK/Thai/Arabic) ·
`note_provider_search_test`, `home_search_test`, `note_editor_save_test`, `handwriting_test`, `export_test`, `reminder_scheduler_test`, `verse_selection_test`,
`iap_service_test`, `consent_service_test`, `ads_rules_test`, `app_lock_test`, `lock_ui_test`, `settings_screen_test`, `premium_screen_test`, `home_actions_test`,
`notebook_detail_test`, … (see `app/test/`). Tests run in CI only (the agent sandbox has no Flutter SDK).

## 10. Build history in dependency order

Each batch was one or more commits, CI-green before the next started. Details and rationale: `decision.md`.

| # | Batch | What it delivered |
|---|---|---|
| 0 | Safety net | `compile-check.yml` (no APK) |
| 1 | Data loss & storage | mode-toggle fallback, failed-save handling, serialised saves, autosave, corrupt-note safety, transactional notebook delete + search-index purge |
| 2 | Search | token quoting, clear-search fix, debounce/stale guard, CJK substring search, ß folding, DB v4 |
| 3 | Lock & privacy | AppLock session, authenticated toggle, hidden previews, gated share/export, AppCompat themes, privacy page |
| 4 | Ads/consent/review/IAP | UMP consent, iOS ad-ID key, native review sheet, purchase/restore messages, cached ad-free flag (three counting/guard changes were later **reverted** at the owner's request) |
| 5 | Appearance & navigation | bundled fonts, real Parchment theme, default paper, Recent chip, direct open, verse header/footer layout, Quill delegate |
| 6 | Handwriting | pointer events, dots, width scaling, segment eraser |
| 7 | Export | handwriting PDF, image-PDF for non-Latin, Unicode filenames, prune at start |
| 8 | Reminders & verses | 14-day verse reminders, stable selection, dedupe 559→492, monochrome icon |
| 9 | Platform metadata | iOS scene manifest, language lists, encryption flag, 16 KB alignment check |
| 10 | Localized errors | typed issues → localized text |
| 11 | Test gaps | Settings/Premium/Home/notebook/provider tests |
| — | **Merge to `main`** | merge commit `079af69`, cleanup `660235c` (phases 0–11) |
| A | Language foundations | zh_Hans/zh_Hant, pt/pt_BR/pt_PT, variant-aware locale code, `regen` mechanism |
| B–E | Languages | ru uk pl cs sk bg ro el · it nl sv da nb fi hu ca · tr id ms vi fil sw th · bn ta te mr gu (+ editor labels for ta te mr fil; Thai substring search) |
| F | Right-to-left | ur, fa, RTL list, Arabic-script search folding (DB v5) |
| — | Verification | stress tests, rendering tests (found the Premium scroll/overflow bug), Argos + NLLB back-translation, full read of all 43 files |
| — | Follow-ups | iOS Face ID/tracking prompts localized (42 lproj), Android channel localized, Quill variant bug + label overlay, CI stale-check + `regen` + SQLite workaround |

**Not yet merged:** everything from batch A onward lives on branch `languages` (50 commits ahead of `main`).

## 11. Commands in dependency order

The agent sandbox has **no Flutter/Dart SDK**; everything that needs Flutter runs in CI.

```bash
# 0. environment (sandbox)
export GITHUB_TOKEN=...                      # ask the owner; never commit it
git clone -b languages https://x-access-token:$GITHUB_TOKEN@github.com/bpprojectsz/Atrament-Aesthetic-Notepad.git

# 1. read a language (key | English | translation | machine back-translation)
python tools/dev/show_translations.py ru --nllb

# 2. change wording: ARB + committed generated Dart together
python tools/dev/apply_l10n_fixes.py fixes.json

# 3. run the checks in CI (never builds an APK)
python tools/dev/gh.py dispatch regen        # regenerate lib/l10n/generated, then `git pull`
python tools/dev/gh.py dispatch check        # stale-check → analyze → tests → Kotlin → link → 16 KB → lint
python tools/dev/gh.py watch                 # wait (≤280 s per call); repeat until completed
python tools/dev/gh.py why                   # annotations of the failed step

# 4. regenerate the file map in this blueprint after adding/moving files
python tools/dev/gen_filemap.py --write

# 5. optional machine checks (free, run on GitHub)
python tools/dev/gh.py dispatch back-translate-nllb
```
Inside the Flutter project (for a human or an environment with Flutter): `cd app && flutter pub get && flutter gen-l10n && flutter analyze && flutter test`.

## 12. File map

Generated from the real import graph — do not edit by hand; run `python tools/dev/gen_filemap.py --write`.

<!-- FILEMAP:BEGIN (generated by tools/dev/gen_filemap.py) -->

### `lib/`

- **`main.dart`** (257 lines) — Defines AtramentApp, _AtramentAppState
  - uses: `core/providers/locale_provider.dart`, `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`, `core/providers/subscription_provider.dart`, `core/providers/theme_provider.dart`, `core/providers/verse_provider.dart`, `core/services/app_lock.dart`, `core/services/engagement_service.dart`, `core/services/export_service.dart`, `core/services/reminder_scheduler.dart`, `core/utils/app_localization_setup.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`, `core/utils/locale_utils.dart`, `core/utils/route_observer.dart`, `platform/admob_service.dart`, `platform/debug_log_service.dart`, `platform/notification_service.dart`, `screens/home_screen.dart`

### `lib/core/`

- **`core/models/note_model.dart`** (120 lines) — Immutable note data. Rich text content is stored as a Quill Delta, serialized to a JSON string (`content`) so it round-trips through SQLite as plain TEXT without a custom column type.
  - used by: `core/providers/note_provider.dart`, `core/services/local_storage.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/models/notebook_model.dart`** (115 lines) — Immutable notebook (folder) data.
  - used by: `core/providers/notebook_provider.dart`, `core/services/local_storage.dart`, `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `widgets/move_to_notebook_sheet.dart`
- **`core/models/paper_style_model.dart`** (153 lines) — Immutable paper texture configuration. Instances are defined as a static catalog (see [PaperStyleCatalog]) rather than user-created, but the model stays generic and serializable for consistency with the rest of the data 
  - used by: `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/settings_screen.dart`, `widgets/note_card.dart`, `widgets/paper_background.dart`, `widgets/paper_selector.dart`
- **`core/models/pen_style_model.dart`** (123 lines) — Immutable pen/tool configuration for the handwriting canvas.
  - used by: `widgets/handwriting_canvas.dart`, `widgets/pen_toolbar.dart`
- **`core/models/verse_model.dart`** (90 lines) — Immutable verse data. Expected schema for `assets/json/daily_verses.json` (a JSON array): ```json [ { "reference": "Psalm 46:1", "text": "God is our refuge and strength, an ever-present help in trouble.", "translation": 
  - used by: `core/providers/verse_provider.dart`, `core/services/reminder_scheduler.dart`, `core/services/verse_service.dart`, `widgets/scripture_footer.dart`, `widgets/scripture_header.dart`, `widgets/scripture_watermark.dart`
- **`core/providers/locale_provider.dart`** (68 lines) — Owns the user's manual language selection. A null [preference] means "follow the device locale" — Flutter's default behaviour when [MaterialApp.locale] is null. A non-null value overrides the system locale and survives r
  - uses: `core/utils/constants.dart`, `core/utils/error_handler.dart`, `core/utils/locale_utils.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/settings_screen.dart`, `widgets/language_picker.dart`
- **`core/providers/note_provider.dart`** (247 lines) — Defines NoteSortOrder, NoteProvider
  - uses: `core/models/note_model.dart`, `core/services/local_storage.dart`, `core/utils/quill_content_helper.dart`, `core/utils/user_issues.dart`, `platform/interstitial_service.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/providers/notebook_provider.dart`** (123 lines) — Owns notebook (folder) CRUD, ordering, and which notebook is currently selected. Talks to [LocalStorage] — no screen or widget touches `sqflite` directly.
  - uses: `core/models/notebook_model.dart`, `core/services/local_storage.dart`, `core/utils/user_issues.dart`, `platform/interstitial_service.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/providers/subscription_provider.dart`** (105 lines) — Owns ad-removal subscription state for the whole app. Wraps [IapService] so screens never import `in_app_purchase` directly.
  - uses: `core/services/iap_service.dart`, `core/utils/constants.dart`, `core/utils/user_issues.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/premium_screen.dart`, `screens/settings_screen.dart`, `widgets/banner_ad_widget.dart`
- **`core/providers/theme_provider.dart`** (140 lines) — Owns the app's theme preference ([ThemePreference]) and the resolved [AppThemeMode] derived from it. State lives in [ValueNotifier]s per Section 15 — widgets bind via [ValueListenableBuilder] or [ListenableBuilder], neve
  - uses: `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/settings_screen.dart`
- **`core/providers/verse_provider.dart`** (123 lines) — Defines VerseDisplayMode, VerseProvider
  - uses: `core/models/verse_model.dart`, `core/services/verse_service.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `main.dart`, `screens/note_editor_screen.dart`, `screens/settings_screen.dart`
- **`core/services/app_lock.dart`** (193 lines) — Result of asking to open protected content.
  - uses: `core/utils/constants.dart`, `core/utils/error_handler.dart`, `platform/biometric_service.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`, `widgets/lock_gate.dart`
- **`core/services/engagement_service.dart`** (233 lines) — Owns all engagement gating: review prompt, share-app prompt, ATT request. Every decision is a pure predicate over counters and timestamps stored in SharedPreferences. Callers report events ("note saved", "export complete
  - uses: `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `main.dart`, `screens/note_editor_screen.dart`, `screens/settings_screen.dart`
- **`core/services/export_page_renderer.dart`** (308 lines) — One rendered page: raw RGBA pixels.
  - uses: `core/utils/export_helper.dart`
  - used by: `core/services/export_service.dart`
- **`core/services/export_service.dart`** (180 lines) — Outcome of an export attempt, surfaced by the caller as an explicit success/error message (Section 15: "every save/delete/share shows explicit success/error feedback").
  - uses: `core/services/export_page_renderer.dart`, `core/utils/error_handler.dart`, `core/utils/export_helper.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/services/iap_service.dart`** (402 lines) — Current subscription state, emitted to `subscription_provider.dart`.
  - uses: `core/utils/constants.dart`, `core/utils/error_handler.dart`, `core/utils/user_issues.dart`
  - used by: `core/providers/subscription_provider.dart`, `platform/interstitial_service.dart`, `screens/premium_screen.dart`, `screens/settings_screen.dart`, `widgets/banner_ad_widget.dart`
- **`core/services/local_storage.dart`** (553 lines) — Result wrapper so callers (providers) can distinguish "empty on purpose" from "failed and fell back to empty," which matters for the visible warning banner required by Section 15.
  - uses: `core/models/note_model.dart`, `core/models/notebook_model.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`
- **`core/services/reminder_scheduler.dart`** (229 lines) — One notification to show: a moment in local time plus its text.
  - uses: `core/models/verse_model.dart`, `core/services/verse_service.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `main.dart`, `platform/notification_service.dart`, `screens/settings_screen.dart`
- **`core/services/verse_service.dart`** (203 lines) — Loads and serves scripture data from two independent local assets: - `daily_verses.json` — a curated pool of mood-tagged verses (see [VerseModel] for the schema) used for the daily rotation shown on the home screen and i
  - uses: `core/models/verse_model.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `core/providers/verse_provider.dart`, `core/services/reminder_scheduler.dart`
- **`core/utils/app_localization_setup.dart`** (71 lines) — The language (and variant) flutter_quill should use for [locale]. flutter_quill picks Chinese and Portuguese variants by *country code*, so the script and region of the app's language have to be turned into one: Traditio
  - uses: `core/utils/locale_utils.dart`, `core/utils/quill_extra_localizations.dart`
  - used by: `main.dart`
- **`core/utils/app_theme.dart`** (58 lines) — Carries the app's real theme choice (light, dark or parchment) inside [ThemeData]. Flutter's own `Brightness` only knows light and dark, so Parchment (a light theme with its own warm colors) was indistinguishable from Li
  - uses: `core/utils/constants.dart`
  - used by: `main.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/premium_screen.dart`, `screens/settings_screen.dart`, `widgets/app_scaffold.dart`, `widgets/chips_row.dart` (+16 more)
- **`core/utils/constants.dart`** (318 lines) — Semantic design tokens for Atrament (Section 17 of the blueprint). Widget code must never reference raw hex values directly — always go through [AppColors], [AppTypography], [AppSpacing], or [AppRadius] so a theme mode s
  - used by: `core/providers/locale_provider.dart`, `core/providers/subscription_provider.dart`, `core/providers/theme_provider.dart`, `core/providers/verse_provider.dart`, `core/services/app_lock.dart`, `core/services/engagement_service.dart`, `core/services/iap_service.dart`, `core/services/local_storage.dart` (+31 more)
- **`core/utils/date_formatter.dart`** (65 lines) — Bucket returned by [DateFormatter.relativeBucket]. The widget layer maps each value to a localized label (e.g. `l10n.today`, `l10n.yesterday`).
  - used by: `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/utils/error_handler.dart`** (118 lines) — Severity classification for reported errors. Used to decide whether a user-facing warning banner is warranted (Section 15: "graceful in-memory fallback + visible warning banner if persistence fails").
  - used by: `core/providers/locale_provider.dart`, `core/providers/theme_provider.dart`, `core/providers/verse_provider.dart`, `core/services/app_lock.dart`, `core/services/engagement_service.dart`, `core/services/export_service.dart`, `core/services/iap_service.dart`, `core/services/local_storage.dart` (+12 more)
- **`core/utils/export_helper.dart`** (272 lines) — One handwriting stroke, in the canvas's own coordinates. Mirrors what is stored in a handwriting note but is independent of the widget layer.
  - used by: `core/services/export_page_renderer.dart`, `core/services/export_service.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/utils/id_generator.dart`** (20 lines) — Generates locally-unique identifiers for new notes and notebooks. Atrament is offline-first with no cross-device sync (Section 1), so a full RFC-4122 UUID (and the extra `uuid` package dependency it would require) isn't 
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/utils/locale_utils.dart`** (139 lines) — Languages that read right-to-left. Keep in sync with lib/l10n.
  - used by: `core/providers/locale_provider.dart`, `core/utils/app_localization_setup.dart`, `main.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`, `widgets/language_picker.dart`
- **`core/utils/notebook_cover_palette.dart`** (65 lines) — Fixed palette for user-chosen notebook cover colors. Deliberately separate from AppColors — AppColors tokens resolve per theme mode, but a notebook's coverColor is stored as a single ARGB int and must look correct agains
  - used by: `widgets/cover_color_picker.dart`
- **`core/utils/paper_default.dart`** (14 lines) — The paper style id chosen as the default in Settings ('cream' until the user picks one). New notes and new notebooks start with it.
  - uses: `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/utils/quill_content_helper.dart`** (41 lines) — Returns the plain-text body of [rawContent], which is either a Quill Delta JSON array (typed notes) or a handwriting wrapper object `{"type":"handwriting","strokes":[...]}`. Handwriting returns an empty string — there is
  - used by: `core/providers/note_provider.dart`, `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`core/utils/quill_extra_localizations.dart`** (1156 lines) — flutter_quill has no translations for these languages, so the app provides its own. Keys are flutter_quill's label names.
  - used by: `core/utils/app_localization_setup.dart`
- **`core/utils/route_observer.dart`** (15 lines) — Global navigator observer used by screens that need to know when they return to the foreground of the navigator stack. Registered in `MaterialApp.navigatorObservers` (see main.dart). Screens that implement [RouteAware] s
  - used by: `main.dart`, `screens/home_screen.dart`
- **`core/utils/user_issues.dart`** (29 lines) — A problem reading from or writing to the device's storage.
  - used by: `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`, `core/providers/subscription_provider.dart`, `core/services/iap_service.dart`, `widgets/user_issue_text.dart`

### `lib/platform/`

- **`platform/admob_service.dart`** (166 lines) — Wraps `google_mobile_ads` initialization and banner loading. Every call site treats failure as a normal, expected outcome — the banner slot collapses to zero height rather than the app crashing or blocking the home scree
  - uses: `core/utils/error_handler.dart`, `platform/consent_service.dart`
  - used by: `main.dart`, `platform/interstitial_service.dart`, `screens/settings_screen.dart`, `widgets/banner_ad_widget.dart`
- **`platform/biometric_service.dart`** (98 lines) — Outcome of a biometric authentication attempt, surfaced by the caller (note_editor_screen's lock overlay) for explicit UI feedback.
  - uses: `core/utils/error_handler.dart`
  - used by: `core/services/app_lock.dart`
- **`platform/consent_service.dart`** (126 lines) — Google's User Messaging Platform (UMP) consent flow. Required for serving ads to users in the EEA / UK: ads must not be requested until the user has made a choice (or none is required where they are). Every call degrades
  - uses: `core/utils/error_handler.dart`
  - used by: `platform/admob_service.dart`, `screens/settings_screen.dart`
- **`platform/debug_log_service.dart`** (121 lines) — Persists errors reported through [ErrorHandler] to a local text file, and exports that file via the system share sheet. Wired in as [ErrorHandler.reportHook] from `main.dart` — `ErrorHandler` itself stays platform-agnost
  - uses: `core/utils/error_handler.dart`
  - used by: `main.dart`, `screens/settings_screen.dart`
- **`platform/interstitial_service.dart`** (108 lines) — Owns interstitial load-and-show with a session-wide cooldown and per-action counters. Callers notify this service that a countable event occurred; the service decides whether to actually show an ad. Never shows an inters
  - uses: `core/services/iap_service.dart`, `core/utils/error_handler.dart`, `platform/admob_service.dart`
  - used by: `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`, `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`
- **`platform/notification_service.dart`** (249 lines) — Local-only notification scheduling for the opt-in daily verse reminder. No server-side push infrastructure — everything here is scheduled on the device via `flutter_local_notifications` (Section 7).
  - uses: `core/services/reminder_scheduler.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`
  - used by: `main.dart`, `screens/settings_screen.dart`
- **`platform/share_service.dart`** (67 lines) — Result of a share attempt, for explicit UI feedback.
  - uses: `core/utils/error_handler.dart`
  - used by: `screens/home_screen.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`

### `lib/screens/`

- **`screens/home_screen.dart`** (823 lines) — Notebook grid dashboard — the app's landing screen. A search field switches the body between the notebook grid and full-text note search results; an FAB creates a new notebook; a banner ad renders at the bottom for free-
  - uses: `core/models/note_model.dart`, `core/models/notebook_model.dart`, `core/models/paper_style_model.dart`, `core/providers/locale_provider.dart`, `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`, `core/providers/subscription_provider.dart`, `core/providers/theme_provider.dart`, `core/services/app_lock.dart`, `core/services/export_service.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/date_formatter.dart`, `core/utils/export_helper.dart`, `core/utils/id_generator.dart`, `core/utils/locale_utils.dart`, `core/utils/paper_default.dart`, `core/utils/quill_content_helper.dart`, `core/utils/route_observer.dart`, `platform/interstitial_service.dart`, `platform/share_service.dart`, `screens/note_editor_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`, `widgets/app_scaffold.dart`, `widgets/banner_ad_widget.dart`, `widgets/chips_row.dart`, `widgets/confirmation_dialog.dart`, `widgets/cover_color_picker.dart`, `widgets/empty_state.dart`, `widgets/language_picker.dart`, `widgets/loading_indicator.dart`, `widgets/lock_gate.dart`, `widgets/move_to_notebook_sheet.dart`, `widgets/new_notebook_dialog.dart`, `widgets/note_actions_menu.dart`, `widgets/note_card.dart`, `widgets/note_list_item.dart`, `widgets/notebook_actions_menu.dart`, `widgets/rename_note_dialog.dart`, `widgets/rename_notebook_dialog.dart`, `widgets/user_issue_text.dart`
  - used by: `main.dart`
- **`screens/note_editor_screen.dart`** (702 lines) — Detects whether a note's stored `content` is a handwriting stroke payload or a Quill Delta, without needing a dedicated schema field. Handwriting content is wrapped as `{"type":"handwriting","strokes":[...]}`; Quill Delt
  - uses: `core/models/note_model.dart`, `core/models/paper_style_model.dart`, `core/providers/note_provider.dart`, `core/providers/verse_provider.dart`, `core/services/app_lock.dart`, `core/services/engagement_service.dart`, `core/services/export_service.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/date_formatter.dart`, `core/utils/error_handler.dart`, `core/utils/export_helper.dart`, `core/utils/locale_utils.dart`, `platform/interstitial_service.dart`, `platform/share_service.dart`, `widgets/font_selector.dart`, `widgets/handwriting_canvas.dart`, `widgets/note_toolbar.dart`, `widgets/paper_background.dart`, `widgets/paper_selector.dart`, `widgets/pen_toolbar.dart`, `widgets/scripture_footer.dart`, `widgets/scripture_header.dart`, `widgets/scripture_watermark.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`screens/notebook_detail_screen.dart`** (511 lines) — Lists the notes within a single notebook, with sort options, an empty state, and a new-note FAB.
  - uses: `core/models/note_model.dart`, `core/models/notebook_model.dart`, `core/providers/note_provider.dart`, `core/providers/notebook_provider.dart`, `core/providers/subscription_provider.dart`, `core/services/app_lock.dart`, `core/services/export_service.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/date_formatter.dart`, `core/utils/export_helper.dart`, `core/utils/id_generator.dart`, `core/utils/locale_utils.dart`, `core/utils/paper_default.dart`, `core/utils/quill_content_helper.dart`, `platform/interstitial_service.dart`, `platform/share_service.dart`, `screens/note_editor_screen.dart`, `widgets/app_scaffold.dart`, `widgets/banner_ad_widget.dart`, `widgets/confirmation_dialog.dart`, `widgets/empty_state.dart`, `widgets/loading_indicator.dart`, `widgets/lock_gate.dart`, `widgets/move_to_notebook_sheet.dart`, `widgets/new_notebook_dialog.dart`, `widgets/note_actions_menu.dart`, `widgets/note_list_item.dart`, `widgets/rename_note_dialog.dart`, `widgets/user_issue_text.dart`
  - used by: `screens/home_screen.dart`
- **`screens/premium_screen.dart`** (220 lines) — Paywall for the ad-removal subscription. Never a blocking modal — always reached from an optional "Remove Ads" row in Settings (Section 19). No feature-gating language anywhere on this screen, since every feature is alre
  - uses: `core/providers/subscription_provider.dart`, `core/services/iap_service.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `widgets/app_scaffold.dart`, `widgets/loading_indicator.dart`, `widgets/user_issue_text.dart`
  - used by: `screens/settings_screen.dart`
- **`screens/settings_screen.dart`** (632 lines) — Theme selection, paper default, font selection, verse display mode, notification toggle, daily reminder time, biometric lock toggle, premium upgrade, restore purchases, and language display.
  - uses: `core/models/paper_style_model.dart`, `core/providers/locale_provider.dart`, `core/providers/subscription_provider.dart`, `core/providers/theme_provider.dart`, `core/providers/verse_provider.dart`, `core/services/app_lock.dart`, `core/services/engagement_service.dart`, `core/services/iap_service.dart`, `core/services/reminder_scheduler.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/error_handler.dart`, `core/utils/locale_utils.dart`, `platform/admob_service.dart`, `platform/consent_service.dart`, `platform/debug_log_service.dart`, `platform/notification_service.dart`, `platform/share_service.dart`, `screens/premium_screen.dart`, `widgets/app_scaffold.dart`, `widgets/banner_ad_widget.dart`, `widgets/confirmation_dialog.dart`, `widgets/font_selector.dart`, `widgets/language_picker.dart`, `widgets/paper_selector.dart`, `widgets/pro_badge.dart`
  - used by: `screens/home_screen.dart`

### `lib/widgets/`

- **`widgets/app_scaffold.dart`** (67 lines) — Reusable scaffold used by every screen. Wraps [Scaffold] with themed background/app-bar colors resolved from the design tokens, a safe area, and an optional bottom slot for [BannerAdWidget] (passed in by the caller so th
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/premium_screen.dart`, `screens/settings_screen.dart`
- **`widgets/banner_ad_widget.dart`** (165 lines) — Delay before retry number [attempt] (0-based) of a failed banner load, or null once retries are used up. Backs off so a no-fill or offline start recovers without hammering the ad server.
  - uses: `core/providers/subscription_provider.dart`, `core/services/iap_service.dart`, `platform/admob_service.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`
- **`widgets/chips_row.dart`** (162 lines) — Which chip is selected on the home screen. Determines which body builder is shown when the search field is empty.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`
- **`widgets/confirmation_dialog.dart`** (87 lines) — Reusable destructive-action confirmation (delete note, delete notebook). Labels are passed in already-localized by the caller.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/settings_screen.dart`
- **`widgets/cover_color_picker.dart`** (168 lines) — Shows a bottom sheet with a 4×4 grid of the sixteen palette colors. Tapping a swatch immediately invokes [onChanged] and the sheet stays open so the user can keep trying colors. Dismiss by swipe-down or tapping outside. 
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`, `core/utils/notebook_cover_palette.dart`
  - used by: `screens/home_screen.dart`
- **`widgets/empty_state.dart`** (67 lines) — Empty state used for zero-notebook home screens, zero-note notebooks, and zero search results. Icon-based rather than a bundled illustration asset, so it needs no image asset dependency.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/font_selector.dart`** (126 lines) — Defines NoteFontChoice, FontSelector
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/note_editor_screen.dart`, `screens/settings_screen.dart`
- **`widgets/handwriting_canvas.dart`** (474 lines) — A single freehand stroke: its points, and the exact visual appearance it was drawn with (color, width, highlighter flag) — captured at draw time rather than stored as a live reference to [PenStyleCatalog]. This matters: 
  - uses: `core/models/pen_style_model.dart`
  - used by: `screens/note_editor_screen.dart`, `widgets/pen_toolbar.dart`
- **`widgets/language_picker.dart`** (175 lines) — Shows the language picker bottom sheet. Selecting "System default" clears the override; selecting a language stores it. Extracted from SettingsScreen so both the Settings row and the home header icon open the same sheet 
  - uses: `core/providers/locale_provider.dart`, `core/utils/constants.dart`, `core/utils/locale_utils.dart`
  - used by: `screens/home_screen.dart`, `screens/settings_screen.dart`
- **`widgets/loading_indicator.dart`** (30 lines) — Branded loading spinner. A thin wrapper over [CircularProgressIndicator] that resolves its color from the design tokens instead of the ambient Material theme, so it stays visually consistent across all three theme modes.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/premium_screen.dart`
- **`widgets/lock_gate.dart`** (29 lines) — Asks the user to unlock before a note leaves the app (share / export). Returns true when it is fine to continue. Shows the explanation itself when the user is refused or the lock had to be switched off.
  - uses: `core/services/app_lock.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/move_to_notebook_sheet.dart`** (106 lines) — Sentinel returned by [showMoveToNotebookSheet] when the user chooses the "Create new notebook" row. A literal id is never equal to this string, so callers can safely check `if (result == kCreateNotebookSentinel)` before 
  - uses: `core/models/notebook_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/name_dialog.dart`** (75 lines) — A small one-field dialog that owns its [TextEditingController]. The controller lives in this widget's State and is disposed with it, so it is never disposed while the dialog is still animating out (which happens if the c
  - used by: `widgets/new_notebook_dialog.dart`, `widgets/rename_note_dialog.dart`, `widgets/rename_notebook_dialog.dart`
- **`widgets/new_notebook_dialog.dart`** (18 lines) — Asks for a new notebook's name. Returns the trimmed name, or null if the user cancelled or left it empty.
  - uses: `widgets/name_dialog.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/note_actions_menu.dart`** (105 lines) — The six actions available on any note row from the 3-dot button.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/note_card.dart`** (158 lines) — Preview card for grid views (home screen notebook grid, note grid) showing a title, a relative date label, and a small paper-texture thumbnail strip.
  - uses: `core/models/paper_style_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`
- **`widgets/note_list_item.dart`** (119 lines) — Note row used on the home screen and in `notebook_detail_screen.dart`. Layout: title, up to two preview lines, then a small date on its own line. Rows are separated by whitespace only — no dividers. The 3-dot menu is the
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/note_toolbar.dart`** (201 lines) — Rich text formatting bar: bold, italic, underline, heading, bullet list, checkbox list, quote, code block. Built directly on `flutter_quill`'s [Attribute] constants rather than the package's prebuilt toolbar widget — [At
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/notebook_actions_menu.dart`** (86 lines) — The three actions available on any notebook card from the 3-dot button.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/home_screen.dart`
- **`widgets/paper_background.dart`** (37 lines) — Renders the selected paper texture as a full-bleed background. Falls back to a solid color if the texture asset ever fails to load, so a missing/corrupt asset degrades to a plain background rather than a broken-image ico
  - uses: `core/models/paper_style_model.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/paper_selector.dart`** (165 lines) — Bottom sheet grid for choosing a paper texture. Labels are passed in already-localized, keyed by [PaperStyleModel.id].
  - uses: `core/models/paper_style_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/note_editor_screen.dart`, `screens/settings_screen.dart`
- **`widgets/pen_toolbar.dart`** (224 lines) — Tool selector for the handwriting canvas: pen/pencil/highlighter, eraser, and a stroke-width slider for the active pen. Labels are passed in already-localized, matching the pattern used by `note_toolbar.dart`.
  - uses: `core/models/pen_style_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `widgets/handwriting_canvas.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/pro_badge.dart`** (43 lines) — Small gold accent badge indicating premium feature context. Used sparingly in Settings — the app has no feature gating (Section 19), so this never blocks interaction; it's purely informational.
  - uses: `core/utils/app_theme.dart`, `core/utils/constants.dart`
  - used by: `screens/settings_screen.dart`
- **`widgets/rename_note_dialog.dart`** (27 lines) — Shows a small dialog pre-filled with [currentTitle] and returns the trimmed new title, or null if the user cancelled. Returns null (no change) if the trimmed result matches [currentTitle] — avoids a pointless save when n
  - uses: `widgets/name_dialog.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`
- **`widgets/rename_notebook_dialog.dart`** (28 lines) — Shows a small dialog pre-filled with [currentName] and returns the trimmed new name, or null if the user cancelled. Returns null (no change) if the trimmed result matches [currentName] — avoids a pointless save when noth
  - uses: `widgets/name_dialog.dart`
  - used by: `screens/home_screen.dart`
- **`widgets/scripture_footer.dart`** (42 lines) — Thin verse reference line shown at the bottom of a note page when the user's verse display mode is set to "footer". Shows the reference only — the full text is available via the header or watermark modes.
  - uses: `core/models/verse_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `widgets/verse_display.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/scripture_header.dart`** (44 lines) — Thin small-caps-style verse line shown at the top of a note page when the user's verse display mode is set to "header".
  - uses: `core/models/verse_model.dart`, `core/utils/app_theme.dart`, `core/utils/constants.dart`, `widgets/verse_display.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/scripture_watermark.dart`** (57 lines) — Faint verse overlay (~8% opacity) rendered behind editor content. Positioned centered or bottom-right per [alignment].
  - uses: `core/models/verse_model.dart`, `widgets/verse_display.dart`
  - used by: `screens/note_editor_screen.dart`
- **`widgets/user_issue_text.dart`** (37 lines) — The user-facing text for a [StorageIssue], in the app's current language.
  - uses: `core/utils/user_issues.dart`
  - used by: `screens/home_screen.dart`, `screens/notebook_detail_screen.dart`, `screens/premium_screen.dart`
- **`widgets/verse_display.dart`** (77 lines) — How much of the verse to render — the reference alone, or the full text with reference.
  - uses: `core/utils/constants.dart`
  - used by: `widgets/scripture_footer.dart`, `widgets/scripture_header.dart`, `widgets/scripture_watermark.dart`

<!-- FILEMAP:END -->

## 13. Outstanding work

See `docs/handoff.md` ("Outstanding" and "Next batches"). This blueprint describes the app as it is, not what is planned.
