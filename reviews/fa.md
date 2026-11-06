# Persian (`fa`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate, natural, correct half-spaces (ZWNJ) and Persian letters. Two fixes. NLLB output was noisy for short Persian labels; sentence meanings matched.

**Confidence:** Medium-high.

## Corrections made
- `paperStyleDotGrid`: “نقطه‌چین” → “نقطه‌ای” — “نقطه‌چین” means a dotted line (the machine split it as “point of China”); “نقطه‌ای” means dotted
- `fontSectionTitle`: “قلم یادداشت‌ها” → “فونت یادداشت‌ها” — “قلم” also means pen (the machine: “The notebook”)
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “آیه روز” → “آیه کتاب مقدس” — “آیه” alone suggests a Quran verse (added in the final pass)

## Left as is, worth a native speaker
- “دفترچه” alone can also mean booklet/brochure (the machine read “brochures”); “دفترچه یادداشت” is unambiguous but longer.
- “خروجی گرفتن” for Export is the Android wording; Windows uses “برون‌بری”.
- “پاصفحه” (Footer) and “نقش‌آب” (Watermark) are Microsoft Persian terms but unfamiliar to some users.
