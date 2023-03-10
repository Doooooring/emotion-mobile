import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";

import "./controller/routeController.dart";
import './page/initial.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await Firebase.initializeApp();
    String title = message.notification?.title ?? "title missing";
    String body = message.notification?.body ?? "body missing";
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          "push notifications", //channelId
          "push notifications", //channelName
          "push notifications", //channelDescription
          importance: Importance.max,
          priority: Priority.high,
        )),
        payload: message.data['default']);
  }

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    firebaseMessagingBackgroundHandler(
        message, flutterLocalNotificationsPlugin);
  });

  final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings());

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payloadData) async {
    if (payloadData != null) {
      //알림페이지 들어갈 부분(foreground 일 때의 동작 -> context 이동하기)
    }
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel",
          "high_importance_channel",
          "High Importance Notifications",
          priority: Priority.max,
          importance: Importance.max,
        ),
      );
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          platformChannelSpecifics,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel",
          "high_importance_channel",
          "High Importance Notifications",
          priority: Priority.max,
          importance: Importance.max,
        ),
      );
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          platformChannelSpecifics,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RouteController());
    return GetMaterialApp(title: "aeye", home: InitialPage());
  }
}
