# Swahili (`sw`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Mostly accurate. Seven fixes, six of them real wording errors. One open vocabulary risk for a native speaker (“dokezo”).

**Confidence:** Low-medium (Swahili is a language I judge with less certainty).

## Corrections made
- `formatItalic`: “Mlalo” → “Italiki” — “mlalo” means horizontal/lying, not italic
- `penHighlighter`: “Kialamisho cha kung’arisha” → “Kalamu ya kuangazia” — “kialamisho” means bookmark
- `paperStyleParchment, themeParchment`: “Ngozi ya karatasi” → “Karatasi ya ngozi” — “skin of paper” → “leather/skin paper”
- `verseModeHeader`: “Kichwa” → “Kichwa cha ukurasa” — same word as Title (sortByTitle)
- `formatHeading`: “Kichwa cha habari” → “Kichwa cha sehemu” — “kichwa cha habari” means a news headline
- `premiumAlreadyProMessage`: “Tayari una Ondoa matangazo.” → “Tayari una “Ondoa matangazo”.” — feature name quoted
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “aya” → “aya ya Biblia” — “aya” alone suggests a Quran verse (added in the final pass)

## Left as is, worth a native speaker
- TOP RISK: “dokezo/madokezo” is used for “note”. The machine kept reading it as hint/suggestion/tip. Ask a native speaker whether “noti”, “maelezo” or “kumbukumbu” is what Swahili phone users expect for a note.
- “Safirisha” (ship) for Export may be less common than “Hamisha” in Swahili software.
- “Panga” (sort) is also the word for machete; context makes it clear but a native speaker may prefer another form.
