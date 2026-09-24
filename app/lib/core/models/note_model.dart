import 'package:flutter/foundation.dart';

/// Immutable note data. Rich text content is stored as a Quill Delta,
/// serialized to a JSON string (`content`) so it round-trips through SQLite
/// as plain TEXT without a custom column type.
@immutable
class NoteModel {
  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.notebookId,
    required this.paperStyle,
    required this.createdAt,
    required this.modifiedAt,
    this.verseReference,
  });

  /// UUID string, generated at creation time by `local_storage.dart`.
  final String id;

  final String title;

  /// Quill Delta JSON, e.g. `[{"insert":"Hello\n"}]`.
  final String content;

  /// Foreign key into `notebooks.id`.
  final String? notebookId;

  /// Foreign key into the paper style catalog, e.g. 'parchment', 'lined'.
  final String paperStyle;

  final DateTime createdAt;
  final DateTime modifiedAt;

  /// Optional "Book 1:1" reference if this note was created from, or
  /// pinned to, a specific verse.
  final String? verseReference;

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    String? notebookId,
    String? paperStyle,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? verseReference,
    bool clearVerseReference = false,
    bool clearNotebook = false,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      notebookId: clearNotebook ? null : (notebookId ?? this.notebookId),
      paperStyle: paperStyle ?? this.paperStyle,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      verseReference: clearVerseReference
          ? null
          : (verseReference ?? this.verseReference),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'notebookId': notebookId,
      'paperStyle': paperStyle,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'verseReference': verseReference,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      notebookId: json['notebookId'] as String?,
      paperStyle: json['paperStyle'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: DateTime.parse(json['modifiedAt'] as String),
      verseReference: json['verseReference'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.notebookId == notebookId &&
        other.paperStyle == paperStyle &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt &&
        other.verseReference == verseReference;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    notebookId,
    paperStyle,
    createdAt,
    modifiedAt,
    verseReference,
  );

  @override
  String toString() => 'NoteModel(id: $id, title: $title)';
}
