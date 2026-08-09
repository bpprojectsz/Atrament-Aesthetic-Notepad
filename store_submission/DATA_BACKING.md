# Data Backing — Privacy Nutrition Label & Data Safety Form Answers

Reference document for filling out App Store Connect's "App Privacy" section
and Google Play Console's "Data safety" form. Answers below trace directly to
what the codebase actually does — update this document first if a feature
changes what data is collected, per Section 12's compliance mapping.

---

## Apple App Store — App Privacy (Privacy Nutrition Label)

### Data Used to Track You
**None.** Atrament does not track users across other companies' apps or
websites. AdMob's advertising identifier use is for in-app ad serving only,
not cross-app tracking by Atrament itself — but ATT permission is still
requested per Apple's policy since AdMob may use it (see below).

### Data Linked to You
| Data type | Collected? | Purpose |
|---|---|---|
| Purchase History | Yes | Subscription status (ad removal) |
| Identifiers (Device ID / Advertising ID) | Yes | Ad serving (AdMob), only if ATT permission granted |

### Data Not Linked to You
| Data type | Collected? | Purpose |
|---|---|---|
| Usage Data | Yes (via AdMob SDK) | Ad performance/analytics from Google's SDK |

### Data Not Collected
- Contact Info
- Health & Fitness
- Financial Info (payment handled entirely by StoreKit, never touches app code)
- Location
- Sensitive Info
- Contacts
- User Content (notes are local-only, never transmitted)
- Browsing History
- Search History
- Diagnostics (no crash reporting SDK is wired in by default — see
  `error_handler.dart`'s optional `reportHook`, which is unset unless a
  crash reporter is deliberately added later)

---

## Google Play — Data Safety Form

### Does your app collect or share any of the required user data types?
**Yes** (via the Google Mobile Ads SDK)

### Data types collected

| Category | Type | Collected | Shared | Purpose |
|---|---|---|---|---|
| Financial info | Purchase history | Yes | No (processed by Play Billing) | App functionality (subscription status) |
| App activity | App interactions | Yes (AdMob only) | Yes (Google) | Advertising |
| Device or other IDs | Advertising ID | Yes | Yes (Google) | Advertising |

### Is all data encrypted in transit?
Yes — all network traffic (AdMob requests, Play Billing) uses HTTPS/TLS by
default via the respective SDKs.

### Do you provide a way for users to request data deletion?
Not applicable for note content — it's stored exclusively on-device and is
deleted immediately when the user uninstalls the app or deletes a note.
Advertising-identifier data held by Google is subject to Google's own
deletion mechanisms (device-level "Reset advertising ID" / "Delete
advertising ID").

### AD_ID permission declaration
Required — declared in `AndroidManifest.xml` implicitly via the
`google_mobile_ads` plugin dependency. Confirm the Play Console's
"Advertising ID" declaration is marked **Yes, my app uses advertising ID**
before submission.

---

## Content rights declaration (Section 12)

- **KJV scripture text**: Public domain. Sourced from a public-domain
  King James Bible dataset (see `FILE_MANIFEST.md`'s data-asset notes for
  provenance).
- **Merriweather font**: SIL Open Font License 1.1. Free for commercial use
  with attribution retained in the font's own metadata — no additional
  action needed beyond bundling the font files as-is.

---

## Checklist before submission

- [ ] Confirm AdMob app IDs in `AndroidManifest.xml` / `Info.plist` are
      real production values, not Google's test IDs
- [ ] Confirm IAP product IDs match what's registered in App Store Connect
      / Play Console exactly
- [ ] Re-verify this document against the actual shipped feature set —
      if biometric lock, notifications, or AdMob integration changes,
      update the tables above first
