# Urdu (`ur`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural Urdu with correct punctuation (۔ ؟). Eleven wording fixes plus the Bible qualifier. NLLB output was usable for Urdu sentences.

**Confidence:** Medium-high.

## Corrections made
- `exportTitle, exportAsTxt, exportAsPdf, noteActionExport, exportFailedMessage, biometricShareReason`: “برآمد” → “ایکسپورٹ” — “برآمد” also means “recovered” (police usage); the machine returned “could not be recovered” for the export-failed message
- `(about 8 strings)`: “نوٹس” → “نوٹ” — “نوٹس” means notice; “نوٹ” works as an invariant plural (machine: “Search for notices”, “notifications”)
- `paperStyleGrid`: “خانہ دار” → “گرڈ” — “خانہ دار” also means housewife/domestic (machine: “Family”)
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “آیت” → “بائبل آیت” — “آیت” alone suggests a Quran verse; the app shows Bible verses

## Left as is, worth a native speaker
- “کالعدم کریں” (Undo) is the Android wording but is legalistic.
- Urdu Nastaliq rendering depends on the phone’s fonts and cannot be judged here.
