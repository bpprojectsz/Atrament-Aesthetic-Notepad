# Thai (`th`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Natural and polite; four fixes. NLLB output was poor for Thai (e.g. “Pencil” → “It’s Dino”), so this is mainly a human read.

**Confidence:** Medium.

## Corrections made
- `paperStyleDotGrid`: “จุดไข่ปลา” → “ตารางจุด” — “จุดไข่ปลา” names the ellipsis “…”, not a dotted page
- `verseSectionTitle, dailyReminderToggle, dailyReminderBody`: “พระคัมภีร์ประจำวัน” → “ข้อพระคัมภีร์ประจำวัน” — “daily Bible” → “daily Bible verse”
- `premiumAlreadyProMessage`: “คุณมี นำโฆษณาออก แล้ว” → “คุณมี “นำโฆษณาออก” แล้ว” — feature name quoted

## Left as is, worth a native speaker
- “บันทึก” means both “save” (verb) and “note” (noun), so sentences like “this note may not have been saved” repeat it. Understandable in context; a native speaker may prefer “โน้ต” for the noun.
- Thai text uses no question marks, which is normal.
