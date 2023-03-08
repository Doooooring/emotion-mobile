import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    //ios, android basic settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings());
    //
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payloadData) async {
        if (payloadData != null) {
          //알림페이지 들어갈 부분(foreground 일 때의 동작 -> context 이동하기)
        }
      },
    );
  }

  static Future<String?> getBackgroundMessage() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    String? payload = notificationAppLaunchDetails!.payload;
    return payload;
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "push notifications", //channelId
        "push notifications", //channelName
        "push notifications", //channelDescription
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id, //message id
        'push notifications', //title
        'You have received a new push notification!', //body
        notificationDetails, //android or ios notificationDetails
        payload: message
            .data['default'], // THIS IS NULL WHEN IN TERMINATED STATE OF APP
      );
    } on Exception catch (e) {
      print('exception: ' + e.toString());
    }
  }
}
