import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart' as quill;

/// Returns the plain-text body of [rawContent], which is either a Quill
/// Delta JSON array (typed notes) or a handwriting wrapper object
/// `{"type":"handwriting","strokes":[...]}`. Handwriting returns an empty
/// string — there is no textual body to extract. Any malformed input also
/// returns an empty string rather than throwing: callers (rename, move,
/// export) run on the note list where a broken note must not crash the
/// menu action.
String plainTextFromContent(String rawContent) {
  final trimmed = rawContent.trim();
  if (trimmed.isEmpty) return '';

  try {
    final decoded = jsonDecode(trimmed);
    if (decoded is Map) return '';
    if (decoded is! List) return '';
    final doc = quill.Document.fromJson(decoded);
    return doc.toPlainText();
  } catch (_) {
    return '';
  }
}

/// Returns the first non-empty, whitespace-trimmed line of [text], capped
/// at [maxLength] characters with a trailing ellipsis if truncated.
/// Returns an empty string if [text] is empty or contains only whitespace.
///
/// Used by NoteProvider.saveNote to auto-title an untitled note from the
/// first line of its content.
String firstNonEmptyLine(String text, {int maxLength = 60}) {
  for (final rawLine in text.split('\n')) {
    final line = rawLine.trim();
    if (line.isEmpty) continue;
    if (line.length <= maxLength) return line;
    return '${line.substring(0, maxLength).trimRight()}…';
  }
  return '';
}
