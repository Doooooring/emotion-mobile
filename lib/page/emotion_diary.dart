import 'package:flutter/material.dart';

import "../asset/init_data.dart";
import "../component/common/bottom_bar.dart";
import "../component/emoticon_diary/calendar/calendar.dart";
import '../component/emoticon_diary/emotion/emotion.dart' as input_emotion;
import "../component/emoticon_diary/emotion/emotion_preview.dart";
import "../component/emoticon_diary/emotion/emotion_selector.dart";

class CalendarWrapper extends StatefulWidget {
  const CalendarWrapper({Key? key}) : super(key: key);

  @override
  State<CalendarWrapper> createState() => _CalendarWrapperState();
}

class _CalendarWrapperState extends State<CalendarWrapper> {
  DateTime dateSelected = DateTime.now();
  void setDateSelected(DateTime date) {
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

  String? curId = null;
  void setCurId(String? id) {
    setState(() {
      curId = id;
    });
  }

  Map curDates = InitDate;
  void setCurDates(Map Dates) {
    setState(() {
      curDates = Dates;
    });
  }

  String? curEmotion = null;

  bool emotionSelectorUp = false;
  void setEmotionSelectorUp(bool state) {
    setState(() {
      emotionSelectorUp = state;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime Today = DateTime.now();
    //EmoticonServices().getEmotionMonth(Today.year, Today.month, setIsLoading);
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
                    height: 30,
                  ),
                  Calendar(
                    curDates: curDates,
                    setDateSelected: setDateSelected,
                    setDateSelectedDeformed: setDateSelectedDeformed,
                    setInputEmotionUp: setInputEmotionUp,
                  ),
                  SizedBox(height: 20),
                  EmotionPreview(
                    curDates: curDates,
                    dateSelected: dateSelected,
                    setInputEmotionUp: setInputEmotionUp,
                    setEmotionSelectorUp: setEmotionSelectorUp,
                  )
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: input_emotion.EmotionWrapper(
                  dateSelected: dateSelected,
                  setInputEmotionUp: setInputEmotionUp,
                  dateSelectedDeformed: dateSelectedDeformed,
                  emotionSelectorUp: emotionSelectorUp,
                  setEmotionSelectorUp: setEmotionSelectorUp,
                ),
                width: 430,
                left: 0,
                top: inputEmotionUp ? 70 : 800,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: EmoticonSelector(
                    emotionSelectorUp: emotionSelectorUp,
                    id: curId,
                    date: dateSelected,
                    emotion: curEmotion),
                width: 430,
                left: 0,
                top: emotionSelectorUp ? 70 : 800,
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
