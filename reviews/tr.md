# Turkish (`tr`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; formal “siz”. Two fixes. NLLB output was unreliable for Turkish short labels (e.g. “Yinele” → “I’m going to eat”); the full read is the real check.

**Confidence:** Medium-high.

## Corrections made
- `premiumAlreadyProMessage`: “Reklamları kaldır zaten sizde.” → “Zaten “Reklamları kaldır” seçeneğine sahipsiniz.” — feature name quoted, natural order
- `emptyRecentNotesTitle`: “Yakın zamanda bir şey yok” → “Son düzenlenen not yok” — “nothing in the near future” was the wrong meaning
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “ayet” → “Kutsal Kitap ayeti” — “ayet” alone suggests a Quran verse (added in the final pass)

## Left as is, worth a native speaker
- “Aydınger” (tracing paper) for Vellum is a reasonable local equivalent.
