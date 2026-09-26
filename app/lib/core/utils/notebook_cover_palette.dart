/// Fixed palette for user-chosen notebook cover colors. Deliberately
/// separate from AppColors — AppColors tokens resolve per theme mode,
/// but a notebook's coverColor is stored as a single ARGB int and must
/// look correct against all three theme backgrounds (light, dark,
/// parchment). These values were chosen to sit in a mid-saturation band
/// that reads on any of the three.
///
/// Users cannot enter a custom color; only these sixteen are offered.
/// That keeps the notebook grid visually coherent and avoids clashing
/// entries.
class NotebookCoverPalette {
  const NotebookCoverPalette._();

  /// Sixteen cover colors. Index 0 is the default for new notebooks.
  static const List<int> all = [
    0xFF8B6914, // warm amber (default, matches AppColors.accent.light)
    0xFFC78D3D, // terracotta
    0xFF4A7C59, // forest green
    0xFF2E5A8A, // deep blue
    0xFF8B2E2E, // burgundy
    0xFF4A4F58, // slate
    0xFF6B3F7A, // plum
    0xFF3D3020, // dark umber
    0xFF9C7B4E, // burnished brass
    0xFFD4A373, // camel
    0xFF8C6E4A, // walnut
    0xFF3F6E5C, // teal pine
    0xFF576F9C, // periwinkle
    0xFF7A4B5C, // mauve
    0xFF5C5C5C, // graphite
    0xFFA67B5B, // chestnut
  ];

  /// First entry, used as the default when creating a notebook without
  /// an explicit choice.
  static int get defaultColor => all.first;

  /// Best-effort label for each color, indexed in parallel with [all].
  /// Used only for accessibility labels and picker tooltips.
  static const List<String> names = [
    'Amber',
    'Terracotta',
    'Forest',
    'Deep Blue',
    'Burgundy',
    'Slate',
    'Plum',
    'Umber',
    'Brass',
    'Camel',
    'Walnut',
    'Teal Pine',
    'Periwinkle',
    'Mauve',
    'Graphite',
    'Chestnut',
  ];

  static int indexOf(int color) {
    final i = all.indexOf(color);
    return i < 0 ? 0 : i;
  }

  static String nameOf(int color) => names[indexOf(color)];
}
