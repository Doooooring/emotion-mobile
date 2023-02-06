import 'package:flutter/material.dart';

import "../asset/init_data.dart";
import "../component/common/bottom_bar.dart";
import "../component/emoticon_diary/calendar/calendar.dart";
import "../component/emoticon_diary/emotion/emotion.dart" as input_emotion;
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

  String? curEmotion = InitDate[DateTime.now().day.toString()]["emotion"];
  void setCurEmotion(String? emotion) {
    setState(() {
      curEmotion = emotion;
    });
  }

  bool emotionSelectorUp = false;
  void setEmotionSelectorUp(bool state) {
    setState(() {
      emotionSelectorUp = state;
    });
  }

  bool navBarUp = true;
  void setNavBarUp(bool state) {
    setState(() {
      navBarUp = state;
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
        Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Calendar(
                      curDates: curDates,
                      setDateSelected: setDateSelected,
                      setCurEmotion: setCurEmotion,
                      setInputEmotionUp: setInputEmotionUp,
                    ),
                    SizedBox(height: 20),
                    EmotionPreview(
                        curDates: curDates,
                        dateSelected: dateSelected,
                        setInputEmotionUp: setInputEmotionUp,
                        setEmotionSelectorUp: setEmotionSelectorUp,
                        setNavBarUp: setNavBarUp)
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: input_emotion.EmotionWrapper(
                  curDates: curDates,
                  dateSelected: dateSelected,
                  setInputEmotionUp: setInputEmotionUp,
                  emotionSelectorUp: emotionSelectorUp,
                  setEmotionSelectorUp: setEmotionSelectorUp,
                ),
                width: 430,
                left: 0,
                top: inputEmotionUp ? 70 : 800,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: SelectorWrapper(
                    setInputEmotionUp: setInputEmotionUp,
                    setEmotionSelectorUp: setEmotionSelectorUp,
                    emotionSelectorUp: emotionSelectorUp,
                    setNavBarUp: setNavBarUp,
                    id: curId,
                    date: dateSelected,
                    emotion: curEmotion,
                    curDates: curDates),
                width: 430,
                height: 800,
                left: 0,
                top: emotionSelectorUp ? 70 : 800,
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavBar(state: navBarUp),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !navBarUp
          ? SizedBox(height: 0)
          : Container(
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
