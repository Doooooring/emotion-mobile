import 'package:aeye/page/babyMonitor/fallAlert.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";

import '../../firebase_options.dart';

Future reqIOSPermission(FirebaseMessaging fbMsg) async {
  NotificationSettings settings = await fbMsg.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

class LocalNotificationController extends GetxController {
  String token = "";
  RxBool messaging = false.obs;

  BuildContext? _context = null;

  void setContext(BuildContext context) {
    _context = context;
    update();
  }

  void getAlert() {
    Get.to(() => BabyMonitor());
  }

  void removeAlert(BuildContext context) {
    Navigator.pop(context);
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    FirebaseApp state = await Firebase.initializeApp(
      name: "a-eye-gdsc",
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("...");
    print(state);
    token = fcmToken!;
    print(fcmToken);

    await FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings());

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notification) {
      String payload = notification.payload ?? "missing title";
      print("is payload");
      print(payload);
      print("...");

      if (_context != null) {
        getAlert();
        return;
      }
    });
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("...onMessage...");
      RemoteNotification? notification = message.notification;
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails(
            "Baby fall",
            "High_Importance_Notifications",
            priority: Priority.max,
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(
              presentBadge: true, sound: "slow_spring_board.aiff"));
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        platformChannelSpecifics,
      );
      print(notification);
      Get.to(() => BabyMonitor());
    });
  }

  void onMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("...on message opened...");
      RemoteNotification? notification = message.notification;
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails(
            "Baby fall",
            "High_Importance_Notifications",
            priority: Priority.max,
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(
              presentBadge: true, sound: "slow_spring_board.aiff"));
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        platformChannelSpecifics,
      );
      if (_context != null) {
        Get.to(() => BabyMonitor());
        // getAlert();
        return;
      }
    });
  }
}
