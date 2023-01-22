import 'package:flutter/material.dart';

import 'calander.dart' as calander;
import 'input_emotion.dart' as input_emotion;

const String url = "http://localhost:3000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => calander.CalanderWrapper(),
      '/emotion': (context) => input_emotion.EmotionWrapper()
    });
  }
}
