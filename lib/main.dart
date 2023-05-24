import "dart:async";

import 'package:aeye/page/advice/ai_chatting.dart';
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
import "firebase_options.dart";

late AndroidNotificationChannel channel;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
      name: "a-eye-fcm", options: DefaultFirebaseOptions.currentPlatform);
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
    title,
    body,
    platformChannelSpecifics,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotificationController localNotificationController =
      LocalNotificationController();
  try {
    await localNotificationController.initialize();
    final fcmTokenNew =
        await FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {});

    print(fcmTokenNew);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    print(e);
  } finally {
    runApp(MyApp(localNotificationController: localNotificationController));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.localNotificationController})
      : super(key: key);

  final LocalNotificationController localNotificationController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  UserController userController = UserController();
  ChildController childController = ChildController();

  String? userInfo = null;

  _asyncMethod() async {
    userInfo = await storage.read(key: "access");
    Get.to(AiChatting(child: "minnu", temperament: "easy", age: 2));
    return;
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
    Get.put(widget.localNotificationController)..setContext(context);
    Get.put(LoginController());
    Get.put(storage);
    Get.put(userController);
    Get.put(childController);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "login",
        home: SplashScreen());
  }
}
