# Telugu (`te`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; sentence-level NLLB back-translations match the English. Six fixes.

**Confidence:** Medium.

## Corrections made
- `paperStyleLined, paperStyleDotGrid, paperStyleGrid`: “గీతల / చుక్కల / గడుల” → “గీతలతో / చుక్కలతో / గడులతో” — bare genitives read as unfinished (“of lines”); machine returned “The rows / Drops / Houses”
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “వచనం” → “బైబిల్ వచనం” — “వచనం” alone reads as plain text/prose

## Left as is, worth a native speaker
- Many loanwords (నోట్, సెట్టింగ్‌లు, సెటప్) are normal in Telugu UI.
- The separate Telugu editor-label set was not part of this read.

## Editor toolbar labels (second set, read later)
Editor labels (106) read in full against Quill’s English: `undo`/`redo` were “రద్దు చేయండి”/“మళ్లీ చేయండి” (the first is also the app’s Cancel) → “అన్‌డూ”/“రీడూ”; `heading1–6`, `headerStyle` → “హెడ్డింగ్ …” and `checkedList` → “చెక్‌లిస్ట్” to match the app’s toolbar. Open: Telugu has no letter case, so “Case sensitive” is meaningless for Telugu text.
