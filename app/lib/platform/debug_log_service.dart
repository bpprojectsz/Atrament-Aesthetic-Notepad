import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/utils/error_handler.dart';

/// Persists errors reported through [ErrorHandler] to a local text file,
/// and exports that file via the system share sheet.
///
/// Wired in as [ErrorHandler.reportHook] from `main.dart` — `ErrorHandler`
/// itself stays platform-agnostic (`core/`) and knows nothing about file
/// I/O; this class is the platform-layer piece that turns each reported
/// error into a persisted line, entirely decoupled from where those
/// errors originate.
class DebugLogService {
  DebugLogService._internal();

  static final DebugLogService instance = DebugLogService._internal();

  /// Caps the log to the most recent entries so it can't grow unbounded
  /// over the app's lifetime. Each entry is a handful of lines, so this
  /// keeps the file well under a size that's awkward to email/share.
  static const int _maxEntries = 200;

  static const String _fileName = 'atrament_debug_log.txt';

  File? _cachedFile;
  final List<Future<void> Function()> _pendingWrites = [];
  bool _isWriting = false;

  Future<File> _logFile() async {
    final cached = _cachedFile;
    if (cached != null) return cached;
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, _fileName));
    _cachedFile = file;
    return file;
  }

  /// Matches [ErrorHandler.reportHook]'s signature — assign directly:
  /// `ErrorHandler.reportHook = DebugLogService.instance.appendToLog;`
  void appendToLog(AppError error) {
    // Queued and serialized rather than fired directly, so concurrent
    // errors (e.g. several storage operations failing in quick
    // succession) can't interleave or race on the same file.
    _pendingWrites.add(() => _writeEntry(error));
    unawaited(_drainQueue());
  }

  Future<void> _drainQueue() async {
    if (_isWriting) return;
    _isWriting = true;
    try {
      while (_pendingWrites.isNotEmpty) {
        final write = _pendingWrites.removeAt(0);
        await write();
      }
    } finally {
      _isWriting = false;
    }
  }

  Future<void> _writeEntry(AppError error) async {
    try {
      final file = await _logFile();
      final timestamp = DateTime.now().toIso8601String();
      final buffer = StringBuffer()
        ..writeln(
          '--- $timestamp | ${error.severity.name} | ${error.context ?? "unknown"} ---',
        )
        ..writeln(error.message)
        ..writeln(error.error?.toString() ?? '')
        ..writeln();

      final existing = await file.exists() ? await file.readAsString() : '';
      final combined = existing + buffer.toString();
      await file.writeAsString(_trimToMaxEntries(combined));
    } catch (_) {
      // Deliberately silent: this is a best-effort diagnostic aid. If
      // writing the log itself fails, there's nothing more useful to do
      // than drop it — reporting *that* failure through ErrorHandler
      // would just re-enter this same hook.
    }
  }

  String _trimToMaxEntries(String content) {
    final entries = content.split('--- ');
    if (entries.length <= _maxEntries) return content;
    final trimmed = entries.sublist(entries.length - _maxEntries);
    return trimmed.map((e) => e.isEmpty ? e : '--- $e').join();
  }

  /// Returns the log file's path if it exists and has content, or `null`
  /// if there's nothing to export yet.
  Future<String?> exportableLogPath() async {
    try {
      final file = await _logFile();
      if (!await file.exists()) return null;
      final size = await file.length();
      if (size == 0) return null;
      return file.path;
    } catch (_) {
      return null;
    }
  }

  /// Clears the log file. Offered alongside the share action in Settings
  /// so a user can start fresh after sending a report.
  Future<void> clearLog() async {
    try {
      final file = await _logFile();
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // Same reasoning as above — best-effort, nothing more to do.
    }
  }
}
