import 'package:flutter/foundation.dart';

/// Immutable paper texture configuration. Instances are defined as a static
/// catalog (see [PaperStyleCatalog]) rather than user-created, but the model
/// stays generic and serializable for consistency with the rest of the data
/// layer and to support persisting a note's chosen style by id.
@immutable
class PaperStyleModel {
  const PaperStyleModel({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.textColor,
    required this.isDark,
  });

  /// Stable identifier persisted on `NoteModel.paperStyle` /
  /// `NotebookModel.paperStyleDefault`, e.g. 'parchment', 'lined'.
  final String id;

  /// Display name — resolved to a localized string by the widget layer via
  /// an id-to-l10n-key lookup; this field holds the catalog default label
  /// used as a fallback if localization is unavailable.
  final String name;

  /// Path into `assets/paper_textures/`.
  final String assetPath;

  /// ARGB integer color value for text rendered on this paper.
  final int textColor;

  /// Whether this texture is a dark background, used to pick a compatible
  /// status bar / app bar icon brightness when displayed.
  final bool isDark;

  PaperStyleModel copyWith({
    String? id,
    String? name,
    String? assetPath,
    int? textColor,
    bool? isDark,
  }) {
    return PaperStyleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      assetPath: assetPath ?? this.assetPath,
      textColor: textColor ?? this.textColor,
      isDark: isDark ?? this.isDark,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assetPath': assetPath,
      'textColor': textColor,
      'isDark': isDark,
    };
  }

  factory PaperStyleModel.fromJson(Map<String, dynamic> json) {
    return PaperStyleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      assetPath: json['assetPath'] as String,
      textColor: json['textColor'] as int,
      isDark: json['isDark'] as bool,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaperStyleModel &&
        other.id == id &&
        other.name == name &&
        other.assetPath == assetPath &&
        other.textColor == textColor &&
        other.isDark == isDark;
  }

  @override
  int get hashCode => Object.hash(id, name, assetPath, textColor, isDark);

  @override
  String toString() => 'PaperStyleModel(id: $id)';
}

/// Static catalog matching the assets manifest (Section 16). Widgets such as
/// `paper_selector.dart` iterate this list rather than hardcoding entries.
class PaperStyleCatalog {
  const PaperStyleCatalog._();

  static const List<PaperStyleModel> all = [
    PaperStyleModel(
      id: 'lined',
      name: 'Lined',
      assetPath: 'assets/paper_textures/lined.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'dot_grid',
      name: 'Dot Grid',
      assetPath: 'assets/paper_textures/dot_grid.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'grid',
      name: 'Grid',
      assetPath: 'assets/paper_textures/grid.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'blank',
      name: 'Blank',
      assetPath: 'assets/paper_textures/blank.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'cream',
      name: 'Cream',
      assetPath: 'assets/paper_textures/cream.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'parchment',
      name: 'Parchment',
      assetPath: 'assets/paper_textures/parchment.png',
      textColor: 0xFF3D3020,
      isDark: false,
    ),
    PaperStyleModel(
      id: 'vellum',
      name: 'Vellum',
      assetPath: 'assets/paper_textures/vellum.png',
      textColor: 0xFF2C2416,
      isDark: false,
    ),
  ];

  static PaperStyleModel byId(String id) {
    return all.firstWhere(
      (style) => style.id == id,
      orElse: () => all.first,
    );
  }
}
