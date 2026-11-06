# Tamil (`ta`) — full read

All 158 strings were read in full against the English text and the key name. Reviewer: Claude (not a native speaker; see confidence).

**Verdict:** Accurate and natural; the NLLB sentence back-translations match the English. Three fixes.

**Confidence:** Medium.

## Corrections made
- `verseModeOff`: “அணைவு” → “முடக்கம்” — “அணைவு” means dam/embankment; the machine returned “dam”
- `verseModeFooter`: “அடிக்குறிப்பு” → “அடிப்பகுதி” — “அடிக்குறிப்பு” means footnote
- `verseSectionTitle`: “இன்றைய வசன காட்சி” → “இன்றைய வசனக் காட்சி” — missing grammatical consonant doubling

## Left as is, worth a native speaker
- “குறிப்பு” for note also means reference/hint (the machine kept reading it as “reference”); it is the standard word for a note in Tamil apps.
- Loanwords (நோட்புக், சிஸ்டம், பார்ச்மென்ட்) are normal in Tamil UI.
