import 'package:flutter/material.dart';

import 'input_emotion.dart' as input_emotion;

const String url = "http://localhost:3000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                leading: Icon(Icons.star),
                title: const Text("ha",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      backgroundColor: Colors.blue,
                    ))),
            body: GestureDetector(
              onTap: () =>
                  FocusScope.of(context).unfocus(), //키보드 이외의 영역 터치시 사라짐
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    //style 느낌
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: input_emotion.EmotionContainer(),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
                child: SizedBox(
              height: 30,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.phone,
                    ),
                    Icon(Icons.message),
                    Icon(Icons.contact_page)
                  ]),
            ))));
  }
}
