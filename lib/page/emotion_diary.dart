import 'package:flutter/material.dart';

import "../asset/init_data.dart";
import "../component/common/bottom_bar.dart";
import "../component/emoticon_diary/calendar/calendar.dart";
import '../component/emoticon_diary/emotion/emotion.dart' as input_emotion;
import "../services/emotion.dart";

class CalendarWrapper extends StatefulWidget {
  const CalendarWrapper({Key? key}) : super(key: key);

  @override
  State<CalendarWrapper> createState() => _CalendarWrapperState();
}

class _CalendarWrapperState extends State<CalendarWrapper> {
  String dateSelected = "null";
  void setDateSelected(String date) {
    setState(() {
      dateSelected = date;
    });
  }

  DateTime dateSelectedDeformed = new DateTime.now();
  void setDateSelectedDeformed(DateTime date) {
    setState(() {
      dateSelectedDeformed = date;
    });
  }

  bool isLoading = false;
  void setIsLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  bool inputEmotionUp = false;
  void setInputEmotionUp(bool state) {
    setState(() {
      inputEmotionUp = state;
    });
  }

  Map curDates = InitDate;
  void setCurDates(Map Dates) {
    setState(() {
      curDates = Dates;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime Today = DateTime.now();
    EmoticonServices().getEmotionMonth(Today.year, Today.month, setIsLoading);
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
                  ),
                  Calendar(
                    curDates: curDates,
                    setDateSelected: setDateSelected,
                    setDateSelectedDeformed: setDateSelectedDeformed,
                    setInputEmotionUp: setInputEmotionUp,
                  )
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: input_emotion.EmotionWrapper(
                    dateSelected: dateSelected,
                    setInputEmotionUp: setInputEmotionUp,
                    dateSelectedDeformed: dateSelectedDeformed),
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
