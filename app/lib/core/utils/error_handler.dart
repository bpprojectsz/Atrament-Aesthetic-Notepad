import 'package:flutter/foundation.dart';

/// Severity classification for reported errors. Used to decide whether a
/// user-facing warning banner is warranted (Section 15: "graceful in-memory
/// fallback + visible warning banner if persistence fails").
enum ErrorSeverity {
  /// Recoverable — e.g. a single save failed but in-memory state is intact.
  warning,

  /// Non-recoverable for the current operation — e.g. database open failed.
  critical,
}

/// A structured error record, decoupled from `FlutterErrorDetails` so it can
/// be logged, displayed, or (later) forwarded to a crash reporting backend
/// without every call site depending on Flutter's error types directly.
@immutable
class AppError {
  const AppError({
    required this.message,
    required this.severity,
    this.error,
    this.stackTrace,
    this.context,
  });

  final String message;
  final ErrorSeverity severity;
  final Object? error;
  final StackTrace? stackTrace;

  /// Short label for where the error originated, e.g. 'local_storage.save'.
  final String? context;

  @override
  String toString() =>
      'AppError(context: $context, severity: $severity, message: $message)';
}

/// Global error boundary. Wired into `FlutterError.onError` and
/// `PlatformDispatcher.instance.onError` from `main.dart`, and called
/// directly by services that catch their own exceptions (e.g.
/// `local_storage.dart`).
///
/// This class has no crash-reporting SDK wired in — see [reportHook] — so it
/// stays dependency-free in `core/`. A real backend (e.g. Sentry, Crashlytics)
/// can be attached at app startup without touching call sites.
class ErrorHandler {
  ErrorHandler._();

  static final ValueNotifier<AppError?> lastError = ValueNotifier<AppError?>(
    null,
  );

  /// Optional sink for forwarding errors to an external crash reporter.
  /// Left unset by default — assigning it is the only integration point
  /// needed to add real crash reporting later.
  static void Function(AppError error)? reportHook;

  /// Records [error]. Always safe to call from a catch block; never throws.
  static void report(
    Object error,
    StackTrace stackTrace, {
    required String message,
    required String context,
    ErrorSeverity severity = ErrorSeverity.warning,
  }) {
    final appError = AppError(
      message: message,
      severity: severity,
      error: error,
      stackTrace: stackTrace,
      context: context,
    );

    if (kDebugMode) {
      debugPrint('[ErrorHandler] $appError\n$stackTrace');
    }

    lastError.value = appError;

    final hook = reportHook;
    if (hook != null) {
      hook(appError);
    }
  }

  /// Clears the last error, e.g. after a warning banner has been dismissed.
  static void clear() {
    lastError.value = null;
  }

  /// Installs the global Flutter framework and platform error handlers.
  /// Call once from `main.dart` before `runApp`.
  static void install() {
    FlutterError.onError = (FlutterErrorDetails details) {
      report(
        details.exception,
        details.stack ?? StackTrace.empty,
        message: details.exceptionAsString(),
        context: 'FlutterError.onError',
        severity: ErrorSeverity.critical,
      );
      FlutterError.presentError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      report(
        error,
        stack,
        message: error.toString(),
        context: 'PlatformDispatcher.onError',
        severity: ErrorSeverity.critical,
      );
      return true;
    };
  }
}
