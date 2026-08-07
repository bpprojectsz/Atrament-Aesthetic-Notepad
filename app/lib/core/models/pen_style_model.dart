import 'package:flutter/foundation.dart';

/// Immutable pen/tool configuration for the handwriting canvas.
@immutable
class PenStyleModel {
  const PenStyleModel({
    required this.id,
    required this.name,
    required this.color,
    required this.strokeWidth,
    required this.isHighlighter,
  });

  /// Stable identifier, e.g. 'fountain_pen', 'highlighter_yellow'.
  final String id;

  /// Catalog default display label (see [PaperStyleModel.name] doc for the
  /// same localization convention).
  final String name;

  /// ARGB integer color value.
  final int color;

  final double strokeWidth;

  /// Highlighters render with reduced opacity and a flat cap in
  /// `handwriting_canvas.dart` rather than a tapered ink stroke.
  final bool isHighlighter;

  PenStyleModel copyWith({
    String? id,
    String? name,
    int? color,
    double? strokeWidth,
    bool? isHighlighter,
  }) {
    return PenStyleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      isHighlighter: isHighlighter ?? this.isHighlighter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'strokeWidth': strokeWidth,
      'isHighlighter': isHighlighter,
    };
  }

  factory PenStyleModel.fromJson(Map<String, dynamic> json) {
    return PenStyleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as int,
      strokeWidth: (json['strokeWidth'] as num).toDouble(),
      isHighlighter: json['isHighlighter'] as bool,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PenStyleModel &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.strokeWidth == strokeWidth &&
        other.isHighlighter == isHighlighter;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, color, strokeWidth, isHighlighter);

  @override
  String toString() => 'PenStyleModel(id: $id)';
}

/// Static catalog for `pen_toolbar.dart`.
class PenStyleCatalog {
  const PenStyleCatalog._();

  static const List<PenStyleModel> all = [
    PenStyleModel(
      id: 'fountain_pen',
      name: 'Fountain Pen',
      color: 0xFF2C2416,
      strokeWidth: 2.5,
      isHighlighter: false,
    ),
    PenStyleModel(
      id: 'gel_pen',
      name: 'Gel Pen',
      color: 0xFF1A3D6B,
      strokeWidth: 1.8,
      isHighlighter: false,
    ),
    PenStyleModel(
      id: 'pencil',
      name: 'Pencil',
      color: 0xFF5C4F3A,
      strokeWidth: 1.2,
      isHighlighter: false,
    ),
    PenStyleModel(
      id: 'highlighter_yellow',
      name: 'Highlighter',
      color: 0x66F5D547,
      strokeWidth: 14,
      isHighlighter: true,
    ),
  ];

  static PenStyleModel byId(String id) {
    return all.firstWhere((style) => style.id == id, orElse: () => all.first);
  }
}
