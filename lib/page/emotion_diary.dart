import 'package:flutter/material.dart';

import "../component/common/bottom_bar.dart";
import "../component/emoticon_diary/calandar/calandar.dart";
import '../component/emoticon_diary/emotion/emotion.dart' as input_emotion;

dynamic getDate(date) {
  Map Month = {
    "01": "Jan",
    "02": "Feb",
    "03": "Mar",
    "04": "Apr",
    "05": "May",
    "06": "Jun",
    "07": "Jul",
    "08": "Aug",
    "09": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec"
  };

  List<String> dateArray = date.split("-");
  dateArray[1] = Month[dateArray[1]];
  dynamic result = dateArray.join(" ");
  return result;
}

class CalanderWrapper extends StatefulWidget {
  const CalanderWrapper({Key? key}) : super(key: key);

  @override
  State<CalanderWrapper> createState() => _CalanderWrapperState();
}

class _CalanderWrapperState extends State<CalanderWrapper> {
  String dateSelected = "null";
  void setDateSelected(String date) {
    setState(() {
      dateSelected = date;
    });
  }

  bool inputEmotionUp = false;
  void setInputEmotionUp(bool state) {
    setState(() {
      inputEmotionUp = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffFAE297),
          elevation: 1.0,
          title: const Text("hmm",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
              ))),
      body: Wrap(children: [
        SizedBox(
          height: 800,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                    // child: IconButton(
                    //    onPressed: () {
                    //      setInputEmotionUp(true);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: const input_emotion.EmotionWrapper(),
                    //         ));
                    //     },
                    //     icon: Icon(Icons.add_circle))),
                  ),
                  Calander(
                    setDateSelected: setDateSelected,
                    setInputEmotionUp: setInputEmotionUp,
                  )
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: input_emotion.EmotionWrapper(
                    dateSelected: dateSelected,
                    setInputEmotionUp: setInputEmotionUp),
                width: 430,
                left: 0,
                top: inputEmotionUp ? 50 : 800,
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: Color(0xffFAE297),
          shape: const CircleBorder(),
          onPressed: () {},
          child: Icon(
            Icons.house,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
