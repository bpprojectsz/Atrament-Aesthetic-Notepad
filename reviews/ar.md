# Arabic (`ar`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate, natural Modern Standard Arabic with correct RTL punctuation. Nine fixes. NLLB output was poor for Arabic short labels and misread “تعذّر” as “excuse me”; sentence meaning was checked by hand.

**Confidence:** High.

## Corrections made
- `shareAppMessage`: “… مع أوراق مميزة” → “… بملمس الورق” — “paper textures” had become “special papers”
- `proLabel`: “مميز” → “احترافي” — “مميز” means special/featured, not Pro
- `shareDebugLogButton, clearDebugLogButton, clearDebugLogTitle, debugLogClearedMessage`: “سجل التصحيح” → “سجل تصحيح الأخطاء” — “التصحيح” alone reads as “correction” (the machine: “correction log”)
- `emptyRecentNotesTitle`: “لا شيء حديث” → “لا توجد ملاحظات حديثة” — stilted
- `legalAndSupportSectionTitle`: “الشؤون القانونية والدعم” → “المعلومات القانونية والدعم” — “legal affairs” is heavier than meant
- `openLinkFailedMessage`: “تعذر فتح الرابط. حاول مرة أخرى.” → “تعذّر فتح الرابط. يُرجى المحاولة مرة أخرى.” — missing diacritic; politeness now matches the other messages
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “آية اليوم / التذكير بالآية” → “… آية الكتاب المقدس” — “آية” alone suggests a Quran verse; the app shows Bible verses (added in the final pass)

## Left as is, worth a native speaker
- The app name is written “أترامنت” in Arabic script while 38 other languages keep “Atrament”.
- “رقّ” (parchment) is the correct word but rare; many users know “ورق البرشمان” (which also means baking paper).
- “قائمة مهام” for Checklist means to-do list, close but not identical.
