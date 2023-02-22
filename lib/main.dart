import 'package:flutter/material.dart';
import "package:get/get.dart";

import './controller/routeController.dart';
import './page/initial.dart';

const String url = "http://localhost:3000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RouteController routerController = Get.put(RouteController());
    return GetMaterialApp(
      title: "aeye",
      home: InitialPage(),
    );
  }
}
