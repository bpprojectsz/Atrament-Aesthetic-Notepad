# Filipino (`fil`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Mostly accurate; many technical terms are English loanwords (normal in Filipino UI). Nine fixes, five of them real meaning problems found by the machine check.

**Confidence:** Medium.

## Corrections made
- `deleteConfirmBody / deleteNotebookWithCountBody`: “Hindi na ito maaaring ibalik.” → “Hindi na ito mababawi.” — “ibalik” means to give back/return, not undo
- `restorePurchasesButton, premiumRestoreButton, restoreSuccessMessage, restoreFailedMessage`: “Ibalik ang mga pagbili …” → “I-restore ang mga pagbili …” — read as “return the purchases” (refund); Filipino app stores use “I-restore”
- `verseSectionTitle`: “Pagpapakita ng talata ng araw” → “Pagpapakita ng pang-araw-araw na talata” — “araw” means both day and sun; the machine read “the sun’s rays”
- `sortOptionsTitle`: “Pagsunud-sunurin” → “I-sort” — consistent with I-save/I-export
- `premiumAlreadyProMessage`: “Mayroon ka na ng Alisin ang mga ad.” → “Mayroon ka na ng “Alisin ang mga ad”.” — feature name quoted

## Left as is, worth a native speaker
- Many labels (Bold, Italic, Heading, Checklist, Header, Footer, Watermark) are kept in English, which matches how Filipino software UIs are written.
- The separate editor-label set for Filipino was not part of this read.
