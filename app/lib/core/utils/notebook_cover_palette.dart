/// Fixed palette for user-chosen notebook cover colors. Deliberately
/// separate from AppColors — AppColors tokens resolve per theme mode,
/// but a notebook's coverColor is stored as a single ARGB int and must
/// look correct against all three theme backgrounds (light, dark,
/// parchment). These values were chosen to sit in a mid-saturation band
/// that reads on any of the three.
///
/// Users cannot enter a custom color; only these eight are offered. That
/// keeps the notebook grid visually coherent and avoids clashing entries.
class NotebookCoverPalette {
  const NotebookCoverPalette._();

  /// Eight cover colors. Index 0 is the default for new notebooks.
  static const List<int> all = [
    0xFF8B6914, // warm amber (default, matches AppColors.accent.light)
    0xFF2E5A8A, // deep blue
    0xFF4A7C59, // forest green
    0xFF8B2E2E, // burgundy
    0xFFC78D3D, // terracotta
    0xFF4A4F58, // slate
    0xFF6B3F7A, // plum
    0xFF3D3020, // dark umber
  ];

  /// First entry, used as the default when creating a notebook without
  /// an explicit choice.
  static int get defaultColor => all.first;

  /// Best-effort label for each color, indexed in parallel with [all].
  /// Used only for accessibility labels and picker tooltips.
  static const List<String> names = [
    'Amber',
    'Blue',
    'Green',
    'Burgundy',
    'Terracotta',
    'Slate',
    'Plum',
    'Umber',
  ];

  static int indexOf(int color) {
    final i = all.indexOf(color);
    return i < 0 ? 0 : i;
  }

  static String nameOf(int color) => names[indexOf(color)];
}
