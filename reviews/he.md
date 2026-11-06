# Hebrew (`he`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; masculine-default imperatives as is standard in Hebrew UI. Two fixes. NLLB output was poor for Hebrew (e.g. “מחברות” → “companies”), and its flag on storageIssueNoteSave was a machine drop: the Hebrew contains both sentences.

**Confidence:** Medium-high.

## Corrections made
- `emptyRecentNotesTitle`: “אין חדש” → “אין פתקים אחרונים” — “nothing new” is not “nothing recent”
- `premiumAlreadyProMessage`: “כבר יש לך הסרת פרסומות.” → “כבר יש לך את “הסרת פרסומות”.” — feature name quoted

## Left as is, worth a native speaker
- The app name is written “אטרמנט” in Hebrew script while 38 other languages keep “Atrament”.
- “בטל נעילה” for Unlock is used by Android; some apps use “שחרר נעילה”.
