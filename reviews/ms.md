# Malay (`ms`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate, Microsoft-style Malay (Buat asal, Penyerlah, Pengepala). Two fixes. NLLB output for Malay was unusable (it even returned profanity for “Share Debug Log”), so this is a human read only.

**Confidence:** Medium (Malay is not a language I judge as reliably).

## Corrections made
- `formatHeading`: “Pengepala” → “Tajuk bahagian” — “Pengepala” was also the translation of Header (page header)
- `premiumAlreadyProMessage`: “Anda sudah mempunyai Alih keluar iklan.” → “Anda sudah mempunyai “Alih keluar iklan”.” — feature name quoted
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “ayat” → “ayat Alkitab” — “ayat” alone suggests a Quran verse (added in the final pass)

## Left as is, worth a native speaker
- “Alih keluar iklan” is Microsoft-style; “Buang iklan” is more everyday Malay.
- “Tukar kulit” for “Change cover” is understood; “Tukar muka depan” is an alternative.
