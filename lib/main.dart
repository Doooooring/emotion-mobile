import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import './page/initial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: "aeye", home: InitialPage());
  }
}
