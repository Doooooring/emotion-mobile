import "package:firebase_core/firebase_core.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import "./controller/NotificationController.dart";
import './controller/routeController.dart';
import './page/initial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RouteController routerController = Get.put(RouteController());
    final NotificationController notificationController =
        Get.put(NotificationController());
    return GetMaterialApp(
        title: "aeye",
        initialBinding: BindingsBuilder(
          () {
            Get.put(NotificationController());
          },
        ),
        home: Obx(() {
          if (NotificationController.to.remoteMessage.value.messageId != null) {
            return Container();
          }
          return InitialPage();
        }));
  }
}
