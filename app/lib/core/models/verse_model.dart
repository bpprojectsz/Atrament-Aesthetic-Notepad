import 'package:flutter/foundation.dart';

/// Immutable verse data.
///
/// Expected schema for `assets/json/daily_verses.json` (a JSON array):
/// ```json
/// [
///   {
///     "reference": "Psalm 46:1",
///     "text": "God is our refuge and strength, an ever-present help in trouble.",
///     "translation": "WEB",
///     "themeCategory": "comfort"
///   }
/// ]
/// ```
/// `verse_service.dart` (Phase 2) rotates through this list by calendar day
/// using `DateFormatter.verseRotationKey`, so the array should contain
/// exactly 365 entries (or 366 with a leap-day fallback handled by the
/// service, e.g. reusing Feb 28's entry).
@immutable
class VerseModel {
  const VerseModel({
    required this.reference,
    required this.text,
    required this.translation,
    required this.themeCategory,
  });

  /// e.g. "Psalm 46:1".
  final String reference;

  final String text;

  /// Translation code, e.g. "KJV", "WEB". Public-domain translations only
  /// (see Section 12 content-rights declaration).
  final String translation;

  /// Loose grouping used for future filtering, e.g. "comfort", "hope",
  /// "wisdom". Not currently user-facing as a filter UI, but reserved.
  final String themeCategory;

  VerseModel copyWith({
    String? reference,
    String? text,
    String? translation,
    String? themeCategory,
  }) {
    return VerseModel(
      reference: reference ?? this.reference,
      text: text ?? this.text,
      translation: translation ?? this.translation,
      themeCategory: themeCategory ?? this.themeCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'text': text,
      'translation': translation,
      'themeCategory': themeCategory,
    };
  }

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      reference: json['reference'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
      themeCategory: json['themeCategory'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VerseModel &&
        other.reference == reference &&
        other.text == text &&
        other.translation == translation &&
        other.themeCategory == themeCategory;
  }

  @override
  int get hashCode =>
      Object.hash(reference, text, translation, themeCategory);

  @override
  String toString() => 'VerseModel(reference: $reference)';
}
