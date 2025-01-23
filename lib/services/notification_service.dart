import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidFlutterLocalNotificationsPlugin().requestExactAlarmsPermission();
    await _notificationsPlugin.cancelAll();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int pendingHabitsSize) async {
    String message;
    if (pendingHabitsSize > 0) {
      message =
          "There are $pendingHabitsSize habits waiting for you to complete!";
    } else {
      message =
          "There is $pendingHabitsSize habit waiting for you to complete!";
    }

    await _notificationsPlugin.show(
      0,
      "Hello",
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<int> scheduleNotification(DateTime time) async {
    const AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails(
      'CHANNEL_ID_1',
      'CHANNEL_NAME_1',
      channelDescription: 'CHANNEL_DESCRIPTION_1',
      enableLights: true,
      color: Color.fromARGB(0, 0, 0, 0),
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );
    final int notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _notificationsPlugin.zonedSchedule(
      notificationId,
      'Habit Tracker',
      'Check your goals for today and stay commited!',
      tz.TZDateTime.from(time, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'Test Payload',
      matchDateTimeComponents: DateTimeComponents.time,
    );

    return notificationId;
  }
}
