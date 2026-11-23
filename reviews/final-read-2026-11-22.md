# Final full read (2026-11-22)

Rule (owner): at the end of the language work every string is read in full by me, one language at a time, with the key name, the English and the translation side by side. No agents, no script choosing what to read, and the machine back-translation is not the basis for any verdict.

All 159 keys of each of the 42 non-English files are read (the display tool stops at 158 by default, so the last key is read in a second call or with range 0 159). Corrections collected in `reviews/final_fixes.json` (applied together, then regenerated and tested).

## English source (159 keys) - read

- **Error:** `premiumBody` says "free with one small banner ad". The app shows banners on the notebook screen and Settings and full-screen ads after some actions. Corrected English: "Atrament is free with ads. Removing them is a one-time purchase that doesn't unlock anything else - every feature is already yours." Every language needs the new sentence (written per language during its read). Same wrong claim in `README.md` and `store_submission/ASO_METADATA.md`.

## Languages

| Locale | Strings read | Corrections | Notes |
|---|---|---|---|
| ar | 159/159 | premiumBody | No wording errors. App name is in Arabic script in `appName` but Latin "Atrament" in rows 109/111/113 (open owner decision, known). "بصمة الوجه" for Face ID is common usage; Apple's own UI writes Face ID. |
| bg | 159/159 | premiumBody | No wording errors. Style only: "Запази/Изтрий" are imperatives while other labels are nouns ("Преименуване"); "стих" alone can also mean a poem line, but string 159 says "стих от Библията". |
| bn | 159/159 | premiumBody | No wording errors. Indic loanwords (বোল্ড, হেডিং, ইরেজার) are the usual app terms; native speaker may prefer others. |
| ca | 159/159 | noDebugLogMessage, premiumBody | 126 "res per informar" was a calque of Spanish; now "cap problema per notificar". Otherwise correct. |
| cs | 159/159 | premiumBody | No wording errors. |
| da | 159/159 | premiumBody | No wording errors. |
| de | 159/159 | emptyRecentNotesTitle, premiumBody | 138 "Nichts Aktuelles" means "nothing current", not "nothing recent"; now "Noch nichts bearbeitet". Otherwise correct. |
| el | 159/159 | premiumBody | No wording errors. "στίχος" alone can mean a poem line (Bible verse is also "εδάφιο"); string 159 says "Αγίας Γραφής". |
| en | 0/159 | deleteNotebookWithCountBody | Source fix: "its {count} notes" reads "its 1 notes" for a single note. |
| de | 0/159 | deleteNotebookWithCountBody | (added after reading es) 152 "seine {count} Notizen" was wrong for one note. |
| es | 159/159 | deleteNotebookWithCountBody, premiumBody | 152 "sus {count} notas" was wrong for one note. Otherwise correct (straight quotes in 12 vs typographic elsewhere: harmless). |
| fa | 159/159 | premiumBody | No wording errors. 152 already count-neutral. "نقطه‌ای" for Dot Grid vs stationery term "نقطه‌چین" left for a native speaker. |
| fi | 159/159 | premiumBody | No wording errors. |
| fil | 159/159 | premiumBody | No wording errors. Many English loanwords (Bold, Italic, Header) are the normal terms in Filipino UI. |
| fr | 159/159 | deleteNotebookWithCountBody, premiumBody | 152 "ses {count} notes" was wrong for one note. "Annuler" is used for both Cancel and Undo (standard in French iOS/Word). Otherwise correct. |
| gu | 159/159 | premiumBody | No wording errors. |
| he | 159/159 | deleteNotebookWithCountBody, emptyAllNotesBody, emptyAllNotesTitle, emptyRecentNotesBody, emptyRecentNotesTitle, moveToNotebookEmptyBody, premiumBody | Inconsistent term: "פתקית" in ~20 strings but "פתק/פתקים" in 136-139, 146, 152; unified to "פתקית". 152 "{count} הפתקים" was wrong for one note. appName in Hebrew script but Latin "Atrament" in rows 109/111/113/120 (known, owner decision). |
| hi | 159/159 | biometricShareReason, dailyReminderBody, dailyReminderToggle, notificationChannelDescription, premiumBody, reminderTimeLabel, shareAppTitle, shareFailedMessage, toggleHandwritingMode, verseSectionTitle | Unified: reminder (रिमाइंडर, was 3 forms), share (साझा, was शेयर/साझा mix), export (निर्यात, 52 had एक्सपोर्ट). 45 "बनाने" -> "ड्रॉइंग". "वचन" alone can mean promise: "बाइबल" added in 92/98/101/159. appName in Devanagari vs Latin in 109-113/120 (known). |
| hu | 159/159 | premiumBody | No wording errors. 138 "Nincs friss elem" is loose but clear. |
| id | 159/159 | premiumBody | No wording errors. "Stabilo" for highlighter is the colloquial brand-generic. |
| it | 159/159 | premiumBody, toggleHandwritingMode | 45 was one-directional ("switch from typing to drawing") on a two-way toggle. "Velina" for Vellum (also tissue paper) left for a native speaker. |
| ja | 159/159 | premiumBody | No wording errors. |
| ko | 159/159 | paperStyleLined, premiumBody, themeSectionTitle | 120 had particle "은" after Atrament vs "를" in 113 (wrong, now "는") and stiff "당신의". 75 "줄무늬" = stripes, now "줄 노트". 87 "모양" = shape, now "외관". Open: "노트북" also means laptop (known). |
| mr | 159/159 | premiumBody | No wording errors. Terms consistent (स्मरणपत्र, निर्यात, बायबल वचन). |
| ms | 159/159 | premiumBody | No wording errors. |
| nb | 159/159 | premiumBody | No wording errors. |
| nl | 159/159 | premiumBody | No wording errors. |
| pl | 159/159 | premiumBody | No wording errors. |
| pt | 159/159 | deleteNotebookWithCountBody, premiumBody | 152 "suas {count} notas" was wrong for one note. Brazilian vocabulary confirmed (salvar, excluir, tela). |
| pt_PT | 159/159 | deleteNotebookWithCountBody, premiumBody | 152 "as respetivas {count} notas" was wrong for one note. European vocabulary confirmed. |
| ro | 159/159 | premiumBody | No wording errors. |
| ru | 159/159 | premiumBody | No wording errors. "Вернуть" for Redo chosen to avoid clashing with Retry ("Повторить"); could read as "return an item" (native speaker). |
| sk | 159/159 | premiumBody | No wording errors. |
| sv | 159/159 | premiumBody | No wording errors. |
| sw | 159/159 | biometricSetupNeededMessage, noteLockTurnedOffMessage, premiumBody | 49 and 54: "hakina kufunga skrini"/"Weka kufunga skrini" used the verb "to lock" where a noun is needed; now "kufuli ya skrini". Open (native speaker): "dokezo" for note, "Karatasi ya ngozi" for parchment, "Italiki". |
| ta | 159/159 | premiumBody | No wording errors. Open (native speaker): "முடக்கம்" for Off (also "disabled/frozen"). |
| te | 159/159 | premiumBody | No wording errors. Terms consistent (రిమైండర్, ఎగుమతి, బైబిల్ వచనం). |
| th | 159/159 | premiumBody | No wording errors. Open (native speaker): "บันทึก" is Save (5), note (~25 strings) and log (124); Apple Notes Thai uses "โน้ต" for the noun. |
| tr | 159/159 | premiumBody | No wording errors. "Kutsal Kitap ayeti" disambiguates from Quran. |
| uk | 159/159 | premiumBody | No wording errors. "вірш" also means a poem; string 159 says "із Біблії". "Повернути" for Redo, as in Russian. |
| ur | 159/159 | emptyRecentNotesTitle, paperStyleGrid, premiumBody | 77 "گرڈ" (loanword) vs the "دار" pattern of 75/76: now "خانے دار". 138 "کچھ حالیہ نہیں" was terse: now "کوئی حالیہ نوٹ نہیں". Open: "کور" for cover (Urdu "سرورق"). |
| vi | 159/159 | premiumBody, shareAppMessage, shareAppSubtitle | 112 "Kể cho một người bạn" = narrate to a friend; now "Giới thiệu cho bạn bè" (recommend). 113 "không xao nhãng" = "not distracted": now "không gây xao nhãng". "Chấm bi" for Dot Grid is used for dotted notebooks (kept). |
| zh | 159/159 | premiumBody | No wording errors (Simplified, mainland terms: 中性笔, 面容 ID, 高级版). |
| zh_Hant | 159/159 | premiumBody | No wording errors. Taiwan wording confirmed (儲存, 設定, 匯出, 檢視, 裝置, 隱私權, 偵錯, 浮水印). 159 "你可選用的每日經文提醒" is correct but a little stiff. |
