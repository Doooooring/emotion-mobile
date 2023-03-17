import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:get/get.dart";

import "./controller/loginController.dart";
import "./controller/routeController.dart";
import "./controller/userController.dart";
import './page/initial.dart';
import "./page/login/login.dart";

// late AndroidNotificationChannel channel;
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(
//   RemoteMessage message,
// ) async {
//   await Firebase.initializeApp();
//   String title = message.notification?.title ?? "title missing";
//   String body = message.notification?.body ?? "body missing";
//   NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: AndroidNotificationDetails(
//       "Baby fall",
//       "High_Importance_Notifications",
//       priority: Priority.max,
//       importance: Importance.max,
//     ),
//   );
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   flutterLocalNotificationsPlugin.show(
//     message.notification.hashCode,
//     message.notification?.title,
//     message.notification?.body,
//     platformChannelSpecifics,
//   );
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // LocalNotificationController localNotificationController =
  //     LocalNotificationController();
  // await localNotificationController.initialize();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  //
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //     iOS: DarwinInitializationSettings());
  //
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse notification) {
  //   String payload = notification.payload ?? "missing title";
  //   log(payload);
  //
  //   //알림페이지 들어갈 부분(foreground 일 때의 동작 -> context 이동하기)
  //
  //   // }, onDidReceiveBackgroundNotificationResponse:
  //   //         (NotificationResponse payloadData) {
  //   //   log("here2");
  // });
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // runApp(MyApp(localNotificationController: localNotificationController));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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

  String? userInfo = null;

  _asyncMethod() async {
    userInfo = await storage.read(key: "access");
    if (userInfo != null) {
      Get.to(InitialPage());
    } else {
      print("Need login authorization");
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _asyncMethod();
    // });

    // widget.localNotificationController.onMessage();
    // widget.localNotificationController.onMessageOpened();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;
    //   NotificationDetails platformChannelSpecifics = NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       "Baby fall",
    //       "High_Importance_Notifications",
    //       priority: Priority.max,
    //       importance: Importance.max,
    //     ),
    //   );
    //   if (notification != null) {
    //     widget.flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       platformChannelSpecifics,
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   log("is background here");
    // });
    //  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(widget.localNotificationController)..setContext(context);
    Get.put(LoginController());
    Get.put(RouteController());
    Get.put(userController);
    Get.put(isAlert);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "login",
        home: userController.access == null ? InitialPage() : Login());

    // return GetBuilder<LocalNotificationController>(builder: (controller) {
    // return GetMaterialApp(title: "hey", home: Login());
    // return GetMaterialApp(title: "aeye", home: InitialPage());

    //   if (controller.messaging.toString() == "true") {
    //     return GetMaterialApp(title: "baby", home: BabyMonitor());
    //   } else {
    //     return GetMaterialApp(title: "aeye", home: InitialPage());
    //   }
    // });
  }
}
