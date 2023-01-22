import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

import 'input_emotion.dart' as input_emotion;

class CalanderWrapper extends StatefulWidget {
  const CalanderWrapper({Key? key}) : super(key: key);

  @override
  State<CalanderWrapper> createState() => _CalanderWrapperState();
}

class _CalanderWrapperState extends State<CalanderWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.star),
            title: const Text("ha",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  backgroundColor: Colors.blue,
                ))),
        body: Column(
          children: [
            SizedBox(
                height: 100,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const input_emotion.EmotionWrapper(),
                              ));
                    },
                    icon: Icon(Icons.add_circle))),
            TableCalendar(
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2023, 12, 30)),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(onPressed: () {}, icon: Icon(Icons.face)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.book))
                  ]),
            )));
  }
}

