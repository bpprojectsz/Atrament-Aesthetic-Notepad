# Indonesian (`id`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; polite “Anda”. Two fixes. NLLB output was mostly noise on short labels; sentences matched the English.

**Confidence:** Medium-high.

## Corrections made
- `premiumAlreadyProMessage`: “Anda sudah memiliki Hapus iklan.” → “Anda sudah memiliki “Hapus iklan”.” — feature name quoted
- `penFountainPen`: “Pulpen tinta” → “Pena tinta” — “pulpen” means ballpoint in modern Indonesian; a fountain pen is “pena”
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “ayat” → “ayat Alkitab” — “ayat” alone suggests a Quran verse (added in the final pass)

## Left as is, worth a native speaker
- “Header/Footer” are borrowed words; “Kepala/Kaki halaman” also exist.
