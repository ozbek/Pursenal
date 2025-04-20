import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    AppLogger.instance.info("Notification received");
  }

  static Future<void> init(Function(String?) onNotificationTap) async {
    try {
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings("ic_notification");
      const DarwinInitializationSettings iOSInitializationSettings =
          DarwinInitializationSettings();

      const LinuxInitializationSettings linuxInitializationSettings =
          LinuxInitializationSettings(defaultActionName: 'Open notification');

      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: androidInitializationSettings,
              iOS: iOSInitializationSettings,
              linux: linuxInitializationSettings);
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          AppLogger.instance.info("Notification clicked: ${response.payload}");
          onNotificationTap(response.payload);
        },
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (e) {
      AppLogger.instance
          .error("Failed to initialise notification service. ${e.toString()}");
    }
  }

  static Future<void> cancelAllNotifications() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      AppLogger.instance
          .error("Failed to cancel all notifications. ${e.toString()}");
    }
  }

  static Future<void> scheduleDailyReminder(int id, String title, String body,
      TimeOfDay time, String screenRoute) async {
    try {
      if (!Platform.isLinux) {
        String channelID = 'pursenal_daily_reminder_channel';

        if (kDebugMode) {
          channelID += "_debug";
        }

        final now = DateTime.now();
        var scheduledTime = DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );

        // Ensure the notification is scheduled for the next occurrence
        if (scheduledTime.isBefore(now)) {
          scheduledTime = scheduledTime.add(const Duration(days: 1));
        }

        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledTime, tz.local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelID,
              'Daily Reminder',
              importance: Importance.high,
              priority: Priority.high,
              icon: 'ic_notification',
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

          matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
          payload: screenRoute,
        );

        AppLogger.instance.info(
            "Daily reminder scheduled at ${scheduledTime.hour}:${scheduledTime.minute}");
      }
    } catch (e) {
      AppLogger.instance
          .error("Failed to schedule daily reminder. ${e.toString()}");
    }
  }
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
}
