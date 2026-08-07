import 'package:flutter/foundation.dart';

/// Immutable notebook (folder) data.
@immutable
class NotebookModel {
  const NotebookModel({
    required this.id,
    required this.name,
    required this.coverColor,
    required this.paperStyleDefault,
    required this.sortOrder,
    required this.createdAt,
  });

  final String id;
  final String name;

  /// ARGB integer color value, persisted directly (not a design token,
  /// since users choose this per-notebook).
  final int coverColor;

  /// Default paper style id applied to new notes in this notebook.
  final String paperStyleDefault;

  /// Manual ordering index for drag-to-reorder on the home screen.
  final int sortOrder;

  final DateTime createdAt;

  NotebookModel copyWith({
    String? id,
    String? name,
    int? coverColor,
    String? paperStyleDefault,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return NotebookModel(
      id: id ?? this.id,
      name: name ?? this.name,
      coverColor: coverColor ?? this.coverColor,
      paperStyleDefault: paperStyleDefault ?? this.paperStyleDefault,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coverColor': coverColor,
      'paperStyleDefault': paperStyleDefault,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory NotebookModel.fromJson(Map<String, dynamic> json) {
    return NotebookModel(
      id: json['id'] as String,
      name: json['name'] as String,
      coverColor: json['coverColor'] as int,
      paperStyleDefault: json['paperStyleDefault'] as String,
      sortOrder: json['sortOrder'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotebookModel &&
        other.id == id &&
        other.name == name &&
        other.coverColor == coverColor &&
        other.paperStyleDefault == paperStyleDefault &&
        other.sortOrder == sortOrder &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    coverColor,
    paperStyleDefault,
    sortOrder,
    createdAt,
  );

  @override
  String toString() => 'NotebookModel(id: $id, name: $name)';
}
