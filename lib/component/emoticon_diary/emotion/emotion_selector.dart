import 'dart:ui';

import 'package:flutter/material.dart';

import "../../../asset/imoticon_url.dart";
import "../../../services/emotion.dart";

EmotionServices emotionServices = new EmotionServices();

class SelectorWrapper extends StatefulWidget {
  const SelectorWrapper({
    Key? key,
    required this.date,
    required this.tempEmotion,
    required this.curDates,
    required this.emotionSelectorUp,
    required this.setCurDate,
    required this.setNavBarUp,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setNavBarUp;
  final bool emotionSelectorUp;

  final DateTime date;
  final String? tempEmotion;
  final Map curDates;

  @override
  State<SelectorWrapper> createState() => _SelectorWrapperState();
}

class _SelectorWrapperState extends State<SelectorWrapper> {
  @override
  Widget build(BuildContext context) {
    Map curInfo = widget.curDates[widget.date.day.toString()];
    int? curId = curInfo["id"];
    String? curEmotion = curInfo["emotion"];

    return SizedBox(
      height: 800,
      child: Column(children: [
        ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    height: 450,
                    child: GestureDetector(
                      onTap: () {
                        widget.setNavBarUp(true);
                        widget.setEmotionSelectorUp(false);
                        widget.setInputEmotionUp(false);
                      },
                    )))),
        EmotionWrapper(
          id: curId,
          date: widget.date,
          emotion: widget.tempEmotion,
          curDates: widget.curDates,
          emotionSelectorUp: widget.emotionSelectorUp,
          setCurDate: widget.setCurDate,
          setInputEmotionUp: widget.setInputEmotionUp,
          setEmotionSelectorUp: widget.setEmotionSelectorUp,
        )
      ]),
    );
  }
}

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper({
    Key? key,
    required this.id,
    required this.date,
    required this.emotion,
    required this.curDates,
    required this.emotionSelectorUp,
    required this.setCurDate,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);

  final int? id;
  final DateTime date;
  final String? emotion;
  final Map curDates;
  final bool emotionSelectorUp;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  @override
  State<EmotionWrapper> createState() => _EmotionWrapperState();
}

class _EmotionWrapperState extends State<EmotionWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 0))
          ],
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("How do you feel?", style: (TextStyle(fontSize: 18)))
                    ])),
            Container(
              height: 100,
              width: 350,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: EmoticonList(
                      widget.id,
                      widget.date,
                      widget.emotion,
                      widget.curDates,
                      widget.setCurDate,
                      widget.setInputEmotionUp,
                      widget.setEmotionSelectorUp,
                      context)),
            ),
          ],
        ));
  }
}

List<Widget> EmoticonList(
    int? id,
    DateTime date,
    String? emotion,
    Map curDates,
    void Function(String, int?, String?, String?) setCurDate,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    BuildContext context) {
  if (emotion == null) {
    return [];
  }
  List<String> curList = ImoticonLink[emotion];
  List<Widget> curWidgets = [];
  for (String str in curList) {
    curWidgets.add(ButtonWrapper(
        id: id,
        setEmotionSelectorUp: setEmotionSelectorUp,
        setInputEmotionUp: setInputEmotionUp,
        setCurDate: setCurDate,
        emotion: str,
        date: date));
  }
  return curWidgets;
}

class ButtonWrapper extends StatefulWidget {
  const ButtonWrapper({
    Key? key,
    required this.id,
    required this.date,
    required this.emotion,
    required this.setCurDate,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final int? id;
  final DateTime date;
  final String emotion;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  @override
  State<ButtonWrapper> createState() => _ButtonWrapperState();
}

class _ButtonWrapperState extends State<ButtonWrapper> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          widget.setEmotionSelectorUp(false);
          widget.setInputEmotionUp(false);
          emotionServices.reviseEmotion(
              widget.id,
              widget.emotion,
              widget.date,
              widget.setEmotionSelectorUp,
              widget.setInputEmotionUp,
              widget.setCurDate);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => EmotionResult()));
        },
        icon: Image.asset(height: 50, width: 50, widget.emotion));
  }
}
