import 'package:aeye/controller/LocalNotificationController.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import "../asset/init_data.dart";
import "../component/common/app_bar.dart";
import "../component/emoticon_diary/calendar/calendar.dart";
import "../component/emoticon_diary/emotion/emotion.dart" as input_emotion;
import "../component/emoticon_diary/emotion/emotion_preview.dart";
import "../component/emoticon_diary/emotion/emotion_selector.dart";
import "../controller/routeController.dart";
import "../services/emotion.dart";

EmotionServices emotionServices = EmotionServices();

class CalendarWrapper extends StatefulWidget {
  const CalendarWrapper({Key? key}) : super(key: key);

  @override
  State<CalendarWrapper> createState() => _CalendarWrapperState();
}

class _CalendarWrapperState extends State<CalendarWrapper> {
  final RouteController routeController = Get.find();
  final LocalNotificationController localNotificationController = Get.find();

  DateTime dateSelected = DateTime.now();
  void setDateSelected(DateTime date) {
    setState(() {
      dateSelected = date;
    });
  }

  bool isLoading = true;
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

  Map<String, Map> curDates = InitDate;
  void setCurDatesAll(Map<String, Map> Dates) {
    setState(() {
      curDates = Dates;
    });
  }

  void setCurDate(String day, int? id, String? text, String? emotion) {
    setState(() {
      if (id != null) {
        curDates[day]?["id"] = id;
      }
      if (text != null) {
        curDates[day]?["content"] = text;
      }
      if (emotion != null) {
        curDates[day]?["emotion"] = emotion;
      }
    });
  }

  String? curTempEmotion;
  void setCurTempEmotion(String? tempEmotion) {
    setState(() {
      curTempEmotion = tempEmotion;
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

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime Today = DateTime.now().toUtc();
    emotionServices.getEmotionMonth(
        Today.year, Today.month, setCurDatesAll, setIsLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(dateSelected),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 800,
            child: Wrap(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 800,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Calendar(
                            textEditController: controller,
                            curDates: curDates,
                            setDateSelected: setDateSelected,
                            setInputEmotionUp: setInputEmotionUp,
                            setCurDateAll: setCurDatesAll,
                            setIsLoading: setIsLoading,
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
                        textController: controller,
                        curDates: curDates,
                        dateSelected: dateSelected,
                        setCurDate: setCurDate,
                        setInputEmotionUp: setInputEmotionUp,
                        setCurTempEmotion: setCurTempEmotion,
                        setEmotionSelectorUp: setEmotionSelectorUp,
                      ),
                      width: MediaQuery.of(context).size.width,
                      left: 0,
                      top: inputEmotionUp ? 50 : 800,
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      child: SelectorWrapper(
                        setNavBarUp: setNavBarUp,
                        date: dateSelected,
                        tempEmotion: curTempEmotion,
                        curDates: curDates,
                        setCurDate: setCurDate,
                        emotionSelectorUp: emotionSelectorUp,
                        setInputEmotionUp: setInputEmotionUp,
                        setEmotionSelectorUp: setEmotionSelectorUp,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      left: 0,
                      top: emotionSelectorUp ? 70 : 800,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
