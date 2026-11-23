# Data Backing — Privacy Nutrition Label & Data Safety Form Answers

Reference for filling in App Store Connect's "App Privacy" section and Google
Play Console's "Data safety" form. It matches `website/privacy.html` (last
updated 2026-11-21) and the shipped behaviour of the app. **The owner submits
the actual forms.** Update this file and the privacy page together whenever a
feature changes what data is handled. This is not legal advice.

## What the app actually does (facts the answers rest on)

- Notes, notebooks, handwriting and settings are stored on the device only.
  Atrament's own code makes no network requests. Network traffic comes only
  from Google's ads library / consent form and from the store's purchase
  service (Apple StoreKit / Google Play Billing).
- Ads (Google AdMob): a banner on the notebook screen and in Settings, and a
  full-screen ad after some actions (save, create, export, delete, a few
  navigation points), at most once every 9 minutes.
- Consent: Google's User Messaging Platform form is shown where required
  (EEA, UK, some US states, once a message is published in the AdMob
  console). A "Privacy choices" row appears in Settings where Google says it
  is required. If Google's answer cannot be read, ads are requested and the
  question is asked once more when the app returns to the foreground.
- A device that bought ad removal gets no banner and no full-screen ads, but
  the ads library may still start and the consent message may still appear.
- iOS only: after the first successful note save the app shows Apple's App
  Tracking Transparency prompt (the code does not check for ad removal first).
- Purchase: one non-consumable "remove ads" product
  (`com.zdmgold.atrament.adfree`). It is not a subscription.
- Daily verse reminder: local notification scheduled on the device (inexact
  alarm), no push server. Verses are bundled; nothing is downloaded.
- Fonts (Merriweather, Inter, Lora) are bundled; nothing is downloaded.
- Diagnostics: a small technical error log is kept **on the device** (written
  by `DebugLogService`, wired in as `ErrorHandler.reportHook`). It is never
  sent automatically; "Share debug log" in Settings lets the user send it.
  No crash-reporting SDK is included.
- Backups: Android auto-backup is at its default (on, no backup rules) and
  iOS backups are not excluded, so the operating system may back up app data.
  Atrament has no backup of its own.
- Biometric / device-credential note lock is handled entirely by the OS; the
  app receives only a yes/no result.
- Android permissions: INTERNET, POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED,
  USE_BIOMETRIC, AD_ID.

---

## Apple App Store — App Privacy (Privacy Nutrition Label)

### Data Used to Track You
**Recommended: declare "Identifiers → Device ID"** (purpose: third-party
advertising). This **changes the earlier answer of "None"**: the app shows
Apple's tracking prompt and uses Google AdMob, which can use the advertising
identifier for personalized ads, so "None" would contradict the prompt. Before
submitting, check Google's current AdMob guidance for the App Store privacy
disclosure and decide the final answer yourself; if you choose "None",
the tracking prompt should not be shown either.

### Data Linked to You
| Data type | Collected? | Purpose |
|---|---|---|
| Purchase History | Yes | App functionality (ad-removal status) |
| Identifiers (Device ID / advertising ID) | Yes (via AdMob) | Third-party advertising |

### Data Not Linked to You
| Data type | Collected? | Purpose |
|---|---|---|
| Usage Data (product interaction, advertising data) | Yes (via the AdMob SDK) | Third-party advertising / ad performance |

Check Google's AdMob disclosure page for the exact categories the current SDK
collects; this table is the minimum the app's own behaviour implies.

### Data Not Collected
- Contact Info, Health & Fitness, Financial Info (payment is handled by
  StoreKit), Location, Sensitive Info, Contacts
- User Content (notes stay on the device; Atrament never transmits them)
- Browsing History, Search History
- Diagnostics (the error log is local and never sent automatically; no
  crash-reporting SDK)

---

## Google Play — Data Safety Form

### Does your app collect or share any of the required user data types?
**Yes** (via the Google Mobile Ads SDK and Play Billing).

### Data types collected

| Category | Type | Collected | Shared | Purpose |
|---|---|---|---|---|
| Financial info | Purchase history | Yes | No (processed by Play Billing) | App functionality (ad-removal status) |
| App activity | App interactions | Yes (AdMob only) | Yes (Google) | Advertising |
| Device or other IDs | Advertising ID | Yes | Yes (Google) | Advertising |

### Is all data encrypted in transit?
Yes. Network traffic (AdMob, consent form, Play Billing) uses HTTPS/TLS via
the respective SDKs. Atrament makes no other network requests.

### Do you provide a way for users to request data deletion?
Not applicable to note content: it exists only on the device and is deleted
when the user deletes a note or uninstalls the app (an OS backup may keep a
copy under the user's Google account, which the user manages). Advertising
data held by Google is subject to Google's own controls (reset or delete the
advertising ID in device settings; the "Privacy choices" row in the app).

### AD_ID permission declaration
`com.google.android.gms.permission.AD_ID` is declared in `AndroidManifest.xml`.
In Play Console's Advertising ID declaration answer **Yes, my app uses
advertising ID** (purpose: advertising).

---

## Content rights declaration

- **KJV scripture text**: public domain (see `FILE_MANIFEST.md` data-asset
  notes for provenance).
- **Fonts**: Merriweather, Inter and Lora are under the SIL Open Font License
  1.1. Their licence files are in `app/assets/fonts/` (`OFL.txt`,
  `OFL-Inter.txt`, `OFL-Lora.txt`); keep them with the font files.

---

## Checklist before submission

- [ ] Deploy `website/` (privacy, terms, support) yourself and confirm the
      privacy URL in both store consoles is the deployed page. The pages are
      English only.
- [ ] Replace Google's test AdMob app and ad-unit IDs with real ones (Android
      manifest, `Info.plist`, `admob_service.dart`). Until then only test ads
      are shown.
- [ ] Publish a consent message in the AdMob console (Privacy & messaging);
      without it the consent form never appears.
- [ ] Add the real App Store ID (Share and Rate links) and the Google
      SKAdNetwork list.
- [ ] Decide the Apple "Data Used to Track You" answer (see above).
- [ ] Confirm the IAP product ID matches App Store Connect / Play Console.
- [ ] Re-verify this document against the shipped feature set if the ad,
      consent, reminder, lock or backup behaviour changes.
