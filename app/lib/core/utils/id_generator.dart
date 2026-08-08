import 'dart:math';

/// Generates locally-unique identifiers for new notes and notebooks.
///
/// Atrament is offline-first with no cross-device sync (Section 1), so a
/// full RFC-4122 UUID (and the extra `uuid` package dependency it would
/// require) isn't necessary — collision risk only matters within a single
/// device's local database, and a timestamp + random suffix is more than
/// sufficient for that.
class IdGenerator {
  const IdGenerator._();

  static final Random _random = Random.secure();

  static String generate() {
    final timestamp = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final randomSuffix = _random.nextInt(1 << 32).toRadixString(36);
    return '${timestamp}_$randomSuffix';
  }
}
