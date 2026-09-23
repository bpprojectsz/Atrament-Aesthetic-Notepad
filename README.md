# Atrament — Aesthetic Notepad

A premium, distraction-free notepad with paper textures, freehand
handwriting, and daily ambient scripture. Offline-first, no account
required, no backend.

## Repository structure

```
atrament/
├── app/                    Flutter app (iOS + Android)
│   ├── lib/
│   │   ├── core/            Platform-agnostic business logic
│   │   │   ├── models/       Immutable data models
│   │   │   ├── providers/    App state (ValueNotifier-based)
│   │   │   ├── services/     SQLite, verses, export, IAP
│   │   │   └── utils/        Constants, formatting, error handling
│   │   ├── platform/        Platform-specific glue (AdMob, notifications,
│   │   │                    biometrics, share) — gated behind dart:io
│   │   ├── screens/         Top-level screens
│   │   ├── widgets/         Reusable UI components
│   │   ├── l10n/            ARB translation files (11 locales)
│   │   └── main.dart
│   ├── assets/               Paper textures, fonts, verse JSON data
│   ├── android/ ios/          Platform projects
│   └── test/                 Unit/widget tests
├── website/                 Static marketing site (hand-written HTML/CSS,
│                            not Flutter Web — see rationale below)
├── store_submission/        ASO metadata, privacy/data-safety answers,
│                            screenshot specs
├── .github/workflows/       Android CI (manual trigger)
├── codemagic.yaml           iOS CI (TestFlight)
└── FILE_MANIFEST.md         Running list of every file in this repo
```

## Why the website isn't Flutter Web

Flutter Web renders to a single `<canvas>` element, which is invisible to
search engine crawlers. Since organic App Store/Play Store discovery
depends partly on a crawlable, indexable marketing site, `website/` is
hand-written static HTML/CSS instead.

## Building the app

```bash
cd app
flutter pub get
flutter run
```

Requires **Flutter 3.24.0 exactly** (pinned in `pubspec.yaml` — the
codebase has been written and reviewed against this specific version's
API surface; newer or older SDKs may not match).

### Before your first build

Several values throughout the codebase are placeholders marked
`com.[youraccount].atrament` or `REPLACE:` — these must be filled in with
real values before the app will build (bundle ID/namespace) or before
submitting to a store (AdMob unit IDs, IAP product IDs, Team ID, privacy
policy URL). See `FILE_MANIFEST.md` for the full list of what's been
generated and what still needs your account-specific values.

**The bundle ID / namespace placeholder in particular blocks even a local
debug build** — unlike the AdMob test IDs (which are real, working Google
sample IDs so the app runs immediately in development), there's no
equivalent stand-in for a package identifier. Pick and set your real
reverse-domain identifier first.

### Running tests and analysis

```bash
cd app
flutter analyze
flutter test
```

## Architecture

- **State management**: `ValueNotifier` per state domain (one provider
  class per domain: theme, subscription, notes, notebooks, verses),
  bound to widgets via `ValueListenableBuilder`/`ListenableBuilder` —
  never `setState` for business logic.
- **Persistence**: `sqflite` (notes/notebooks, with an FTS5 full-text
  search index) + `SharedPreferences` (settings). No backend, no cloud
  sync, entirely local.
- **Monetization**: free tier with every feature fully functional; a
  single small banner ad; a one-time $14.99 purchase removes the ad and
  unlocks nothing else, since nothing is gated.
- **Localization**: 11 languages via ARB files and
  `flutter_localizations`, including RTL support for Arabic and Hebrew.
- **Error handling**: a global `ErrorHandler` (installed in `main.dart`)
  catches framework and platform errors; every storage/plugin operation
  degrades gracefully rather than crashing (e.g. AdMob failures collapse
  the banner slot to zero height instead of taking down the app).

## CI/CD

Both pipelines trigger manually (`workflow_dispatch` / no auto-build on
push) to conserve free-tier CI minutes during active development:

- **Android** — GitHub Actions (`.github/workflows/build_and_deploy.yml`):
  builds both an AAB (Play Store) and APK (sideload testing), obfuscated,
  with debug symbols split out.
- **iOS** — Codemagic (`codemagic.yaml`): builds an IPA and submits to
  TestFlight automatically; does not auto-submit to the App Store.

## License / content attribution

- Scripture text: King James Version, public domain.
- Merriweather font: SIL Open Font License 1.1.
