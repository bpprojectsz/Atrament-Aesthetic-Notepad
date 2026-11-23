# Hindi (`hi`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Mostly accurate and natural; formal register with English loanwords (normal for Hindi UI). Seven wording fixes plus a spelling normalisation (एँ → एं). NLLB output was usable for Hindi.

**Confidence:** Medium-high.

## Corrections made
- `sortByCreated`: “निर्माण तिथि” → “बनाए जाने की तारीख” — “निर्माण” means construction (the machine read “Construction date”)
- `saveFailedMessage, exportFailedMessage, shareFailedMessage, openLinkFailedMessage`: “पुनः प्रयास करें / “नहीं खोल सका”” → “कृपया फिर से कोशिश करें / “नहीं खोला जा सका”” — one message used a wrong grammatical form; retry wording unified
- `shareAppMessage`: “… बिना ध्यान-भंग नोटपैड” → “… ध्यान न भटकाने वाला नोटपैड” — awkward phrase
- `premiumAlreadyProMessage`: “… विज्ञापन हटाएं सुविधा है” → “… “विज्ञापन हटाएं” सुविधा है” — feature name quoted
- `(~10 strings)`: “हटाएँ/बनाएँ…” → “हटाएं/बनाएं…” — file mixed two spellings of the same ending

## Left as is, worth a native speaker
- The app name is written “एट्रामेंट” in Devanagari while 38 other languages keep “Atrament”.
- “पार्चमेंट” and “वेलम” are transliterations; “चर्मपत्र” is the native word for parchment.
