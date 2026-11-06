# Bengali (`bn`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; polite “আপনি”. Six fixes for ambiguity, all found by the NLLB back-translation (usable for Bengali).

**Confidence:** Medium-high.

## Corrections made
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “পদ” → “বাইবেলের পদ” — “পদ” also means post/position; the machine read “today’s posts”
- `noteActionMoveToNotebook, moveToNotebookTitle`: “নোটবুকে সরান” → “নোটবুকে নিয়ে যান” — “সরান” means remove; the machine read “Remove the notebook”
- `paperStyleGrid`: “চৌকো ঘর” → “গ্রিড” — “square house”

## Left as is, worth a native speaker
- “চেহারা” (face) for Appearance is colloquial; a native speaker may prefer another term.
- “সরান” is still used for “Remove Ads”, where remove is the intended meaning.
