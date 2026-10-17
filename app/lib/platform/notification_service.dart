import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../core/services/reminder_scheduler.dart';
import '../core/utils/constants.dart';
import '../core/utils/error_handler.dart';

/// Local-only notification scheduling for the opt-in daily verse reminder.
/// No server-side push infrastructure — everything here is scheduled on
/// the device via `flutter_local_notifications` (Section 7).
class NotificationService implements ReminderGateway {
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

      // tz.local defaults to UTC until explicitly set. Read the device
      // zone and pin it so the user's chosen hour is honored locally,
      // including DST transitions.
      try {
        final tzInfo = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(tzInfo.identifier));
      } catch (error, stackTrace) {
        ErrorHandler.report(
          error,
          stackTrace,
          message: 'Failed to set local timezone; defaulting to UTC',
          context: 'notification_service.setLocalTimezone',
          severity: ErrorSeverity.warning,
        );
      }

      // A monochrome status-bar icon. Android draws notification icons as a
      // flat silhouette, so the colored launcher icon would show as a plain
      // white square.
      const androidSettings = AndroidInitializationSettings(
        'ic_stat_notification',
      );
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      await _plugin.initialize(
        settings: const InitializationSettings(
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

  /// How many notification ids are reserved after
  /// [AppConstants.dailyVerseNotificationId]. Cancelling sweeps all of them,
  /// so a smaller window later can never leave stale reminders behind.
  static const int _reservedIdCount = 30;

  /// Replaces every pending reminder with [reminders]: one individual
  /// notification per entry, each with its own text. Returns whether every
  /// one was scheduled.
  @override
  Future<bool> scheduleReminders(List<ReminderNotification> reminders) async {
    try {
      await cancelReminders();
      for (var i = 0; i < reminders.length && i < _reservedIdCount - 1; i++) {
        final reminder = reminders[i];
        final when = tz.TZDateTime(
          tz.local,
          reminder.when.year,
          reminder.when.month,
          reminder.when.day,
          reminder.when.hour,
          reminder.when.minute,
        );
        await _plugin.zonedSchedule(
          id: AppConstants.dailyVerseNotificationId + 1 + i,
          title: reminder.title,
          body: reminder.body,
          scheduledDate: when,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              AppConstants.dailyVerseNotificationChannelId,
              'Daily Verse',
              channelDescription: 'Your opt-in daily scripture reminder',
              importance: Importance.defaultImportance,
              priority: Priority.defaultPriority,
              // Lets the whole verse be read when the notification expands.
              styleInformation: BigTextStyleInformation(reminder.body),
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
      return true;
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to schedule daily reminders',
        context: 'notification_service.scheduleReminders',
        severity: ErrorSeverity.warning,
      );
      return false;
    }
  }

  /// Removes every pending reminder, including the single repeating one
  /// that earlier versions of the app scheduled under the base id.
  @override
  Future<void> cancelReminders() async {
    try {
      for (var i = 0; i < _reservedIdCount; i++) {
        await _plugin.cancel(id: AppConstants.dailyVerseNotificationId + i);
      }
    } catch (error, stackTrace) {
      ErrorHandler.report(
        error,
        stackTrace,
        message: 'Failed to cancel daily reminders',
        context: 'notification_service.cancelReminders',
        severity: ErrorSeverity.warning,
      );
    }
  }
}
