import "dart:async";

import "package:aeye/firebase_options.dart";
import 'package:aeye/page/splash_screen.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:get/get.dart";

import "./controller/childController.dart";
import "./controller/localNotificationController.dart";
import "./controller/loginController.dart";
import "./controller/userController.dart";
import './page/initial.dart';
import "./page/login/login.dart";

late AndroidNotificationChannel channel;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    name: "A-eye",
  );
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotificationController localNotificationController =
      LocalNotificationController();
  await localNotificationController.initialize();
  await Firebase.initializeApp(
    name: "A-eye",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  localNotificationController.token = fcmToken!;
  print(fcmToken);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings());

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notification) {
      String payload = notification.payload ?? "missing title";
    },
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp(localNotificationController: localNotificationController));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.localNotificationController})
      : super(key: key);

  final LocalNotificationController localNotificationController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAlert = false;
  void setIsAlert(bool state) {
    setState(() {
      isAlert = state;
    });
  }

  FlutterSecureStorage storage = FlutterSecureStorage();
  UserController userController = UserController();
  ChildController childController = ChildController();

  String? userInfo = null;

  _asyncMethod() async {
    await storage.deleteAll();

    userInfo = await storage.read(key: "access");
    if (userInfo != null) {
      Timer(Duration(milliseconds: 1500), () {
        Get.to(InitialPage());
      });
    } else {
      Timer(Duration(milliseconds: 1500), () {
        Get.to(Login());
      });
    }
  }

  @override
  void initState() {
    widget.localNotificationController.onMessage();
    widget.localNotificationController.onMessageOpened();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(widget.localNotificationController);
    Get.put(LoginController());
    Get.put(userController);
    Get.put(childController);
    Get.put(isAlert);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "login",
        home: SplashScreen());
  }
}

// MediaQuery(
// data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
