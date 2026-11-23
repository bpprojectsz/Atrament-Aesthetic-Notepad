# Quill editor labels (flutter_quill) — what was read and what was not

**Scope, stated plainly.** The app draws its own editor toolbar from the app's
translations (`note_toolbar.dart`) and uses Quill only for the editing surface.
Quill's own labels therefore appear only in menus tied to links inside a note
(open, copy, remove, edit, apply, visit link), and the app cannot create links.
I read **those eleven labels in all 38 language variants** against Quill's English.
I did **not** read the other ~95 labels in each language (image, video, table,
search-settings and similar): the app never shows them.

## Bug found and fixed
Quill picks Chinese and Portuguese variants by *country code*, but the app passed
only the language. Traditional Chinese users got the Simplified file and Brazilian
users the plain `pt` file (which leaves labels such as “Redo” in English). Now:
`zh_Hant → zh_TW`, `zh_Hans → zh_CN`, `pt_BR` and `pt_PT → pt_BR` (the complete file).

## Errors in Quill's own translations, corrected with an overlay
| Language | Label | Quill says | Now |
|---|---|---|---|
| Arabic | pasteLink / ok | “نسخ الرابط” (= copy link) / “نعم” (= yes) | لصق رابط / موافق |
| Bulgarian | ok | Да (= yes) | ОК |
| Danish | edit, apply, text, visitLink, remove | English; “Fjerne” | Rediger, Anvend, Tekst, Besøg link, Fjern |
| Japanese | apply, visitLink | 応用 (= applied science), ハイパーリンクを訪問 | 適用, リンクを開く |
| Korean | text | 제목 (= title) | 텍스트 |
| Malay | apply, text, visitLink | English; “Perkataan” (= word) | Guna, Teks, Lawati pautan |
| Dutch | remove, edit, apply, visitLink | “Verwijderd” (= removed); English | Verwijderen, Bewerken, Toepassen, Link bezoeken |
| Polish | edit, apply, visitLink | English | Edytuj, Zastosuj, Odwiedź link |
| Swahili | edit | Harir | Hariri |
| Turkish | open, text, save | Açık (= turned on), English, “Kayıt Et” | Aç, Metin, Kaydet |
| Urdu | edit | ترتیب دیں (= arrange) | ترمیم کریں |
| Traditional Chinese | apply, visitLink, open | mainland wording 應用 / 訪問鏈接 | 套用, 前往連結, 開啟 |

## Known gaps left
- In most languages Quill lacks nine newer labels (image/video save messages and
  “open file”); they fall back to English. Unreachable in this app.
- Quill's Danish, Polish, Dutch, Portuguese and Malay files still hold 40–54
  untranslated labels each; the reachable ones are fixed above.
- Quill's Chinese Traditional file uses a few mainland terms elsewhere (e.g. 鏈接).
- The editor-label sets for Tamil, Telugu, Marathi and Filipino are the app's own
  and were read separately (see their review files).
- Not read by a native speaker.
