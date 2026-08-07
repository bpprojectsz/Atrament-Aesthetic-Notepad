import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';

/// Local-only notification scheduling for the opt-in daily verse reminder.
/// No server-side push infrastructure — everything here is scheduled on
/// the device via `flutter_local_notifications` (Section 7).
class NotificationService {
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initializes the plugin and timezone database. Call once at app
  /// startup. Never throws — a failure here means notifications simply
  /// won't fire, which degrades gracefully rather than blocking the app.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      tz_data.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      await _plugin.initialize(
        const InitializationSettings(
          android: androidSettings,
          iOS: iosSettings,
        ),
      );

      if (Platform.isAndroid) {
        final androidPlugin = _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            AppConstants.dailyVerseNotificationChannelId,
            'Daily Verse',
            description: 'Your opt-in daily scripture reminder',
            importance: Importance.defaultImportance,
          ),
        );
      }

      _initialized = true;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Notification service failed to initialize',
        context: 'notification_service.initialize',
        severity: ErrorSeverity.warning,
      );
    }
  }

  /// Requests the OS-level notification permission. Returns whether
  /// permission was granted; the caller (settings_screen) should only
  /// enable the reminder toggle if this returns true.
  Future<bool> requestPermission() async {
    try {
      if (Platform.isIOS) {
        final granted = await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return granted ?? false;
      }
      if (Platform.isAndroid) {
        final granted = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        return granted ?? false;
      }
      return false;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Notification permission request failed',
        context: 'notification_service.requestPermission',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }

  /// Schedules (or reschedules) the daily verse reminder for [hour]:[minute]
  /// local time, repeating every day. [verseTitle] and [verseBody] are the
  /// already-resolved localized notification text — this service does no
  /// verse selection or localization itself.
  Future<bool> scheduleDailyReminder({
    required int hour,
    required int minute,
    required String verseTitle,
    required String verseBody,
  }) async {
    try {
      final scheduledDate = _nextInstanceOf(hour, minute);

      await _plugin.zonedSchedule(
        AppConstants.dailyVerseNotificationId,
        verseTitle,
        verseBody,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.dailyVerseNotificationChannelId,
            'Daily Verse',
            channelDescription: 'Your opt-in daily scripture reminder',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      return true;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to schedule daily reminder',
        context: 'notification_service.scheduleDailyReminder',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }

  Future<void> cancelDailyReminder() async {
    try {
      await _plugin.cancel(AppConstants.dailyVerseNotificationId);
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to cancel daily reminder',
        context: 'notification_service.cancelDailyReminder',
        severity: ErrorSeverity.warning,
      );
    }
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
