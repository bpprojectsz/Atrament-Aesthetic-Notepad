# Marathi (`mr`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; sentence-level NLLB back-translations match the English. Four fixes.

**Confidence:** Medium.

## Corrections made
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “वचन” → “बायबल वचन” — “वचन” also means promise (the machine read “Daily Promise Reminder”)
- `rateAppSubtitle`: “परीक्षण लिहा” → “पुनरावलोकन लिहा” — “परीक्षण” means examination/test; the machine returned “Write a test”

## Left as is, worth a native speaker
- Many loanwords (नोट, सिस्टीम, फूटर) are normal in Marathi UI.
- The separate Marathi editor-label set was not part of this read.
