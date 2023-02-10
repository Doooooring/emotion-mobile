import 'package:flutter/material.dart';

import './page/baby_monitor.dart';
import './page/emotion_diary.dart';
import './page/initial.dart';

const String url = "http://localhost:3000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => InitialPage(),
        '/diary': (context) => CalendarWrapper(),
        '/baby_monitor': (context) => BabyMonitor()
      },
    );
  }
}
