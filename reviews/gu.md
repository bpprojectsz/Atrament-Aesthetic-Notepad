# Gujarati (`gu`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; sentence-level NLLB back-translations match the English. Six fixes.

**Confidence:** Medium.

## Corrections made
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “વચન” → “બાઇબલ વચન” — “વચન” also means promise (machine: “A daily promising reminder”)
- `legalAndSupportSectionTitle, supportSectionTitle, supportRow`: “સહાય” → “સપોર્ટ” — “કાનૂની સહાય” reads as “legal aid”; “સહાય” means aid/help, “સપોર્ટ” is the usual customer-support word

## Left as is, worth a native speaker
- “નોંધ” (note) also means record/entry; it is the standard word for a note in Gujarati apps.
- The separate Gujarati strings were never in the editor-label set (Quill supports Gujarati).
