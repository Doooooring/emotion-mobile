import 'package:aeye/page/babyMonitor/fallAlert.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";

import '../../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
  String title = message.notification?.title ?? "title missing";
  String body = message.notification?.body ?? "body missing";
  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      "Baby fall",
      "High_Importance_Notifications",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.show(
    message.notification.hashCode,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
  );
}

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
    await Firebase.initializeApp(
      name: "aeye",
      options: DefaultFirebaseOptions.currentPlatform,
    );

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
      print("is hererre");
      if (_context != null) {
        print("here");
        getAlert();
        return;
      }
      //알림페이지 들어갈 부분(foreground 일 때의 동작 -> context 이동하기)

      // }, onDidReceiveBackgroundNotificationResponse:
      //         (NotificationResponse payloadData) {
      //   log("here2");
    });
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print(notification);
      print("it's getting message");
      Get.to(() => BabyMonitor());
    });
  }

  void onMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
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
        notification!.body,
        platformChannelSpecifics,
      );
      if (_context != null) {
        print("get some message");
        Get.to(() => BabyMonitor());
        // getAlert();
        return;
      }
    });
  }
}
