import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payloadData) async {
      if (payloadData != null) {
        //알림페이지 들어갈 부분
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "push notifications",
        "push notifications",
        "push notifications",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id,
        'push notifications',
        'You have received a new push notification!',
        notificationDetails,
        payload: message
            .data['default'], // THIS IS NULL WHEN IN TERMINATED STATE OF APP
      );
    } on Exception catch (e) {
      print('exception: ' + e.toString());
    }
  }
}
