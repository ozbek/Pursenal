import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:timezone/timezone.dart' as tz;

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
          AndroidInitializationSettings("@mipmap/ic_launcher");
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
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_reminder_channel',
              'Daily Reminder',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
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
