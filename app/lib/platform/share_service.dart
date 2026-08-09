import 'package:share_plus/share_plus.dart';

import '../core/utils/error_handler.dart';

/// Result of a share attempt, for explicit UI feedback.
class ShareResult {
  const ShareResult.success() : failed = false;
  const ShareResult.failure() : failed = true;

  final bool failed;
}

/// Wraps `share_plus` to hand exported files off to the system share sheet.
/// This is the only file that imports `share_plus` directly — all other
/// export flow lives in `core/services/export_service.dart`, which writes
/// bytes to disk but never presents UI.
///
/// Uses the static `Share.shareXFiles` / `Share.share` API, which is what
/// `share_plus ^9.0.0` (the pinned version) exposes — the newer
/// `SharePlus.instance.share(ShareParams(...))` instance API was
/// introduced in a later major version and isn't available here.
class ShareService {
  const ShareService();

  /// Shares a single file at [filePath] via the system share sheet.
  /// [subject] is used as the email subject line on platforms that support
  /// it; ignored elsewhere.
  Future<ShareResult> shareFile(
    String filePath, {
    String? subject,
  }) async {
    try {
      await Share.shareXFiles([XFile(filePath)], subject: subject);
      return const ShareResult.success();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to open share sheet',
        context: 'share_service.shareFile',
        severity: ErrorSeverity.warning,
      );
      return const ShareResult.failure();
    }
  }

  /// Shares plain text directly (e.g. a verse reference + text) without an
  /// associated file.
  Future<ShareResult> shareText(String text, {String? subject}) async {
    try {
      await Share.share(text, subject: subject);
      return const ShareResult.success();
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to share text',
        context: 'share_service.shareText',
        severity: ErrorSeverity.warning,
      );
      return const ShareResult.failure();
    }
  }
}
