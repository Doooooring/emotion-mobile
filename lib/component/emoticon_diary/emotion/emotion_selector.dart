import "dart:developer";
import 'dart:ui';

import 'package:flutter/material.dart';

import "../../../asset/imoticon_url.dart";

class SelectorWrapper extends StatefulWidget {
  const SelectorWrapper(
      {Key? key,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.emotionSelectorUp,
      required this.setNavBarUp,
      required this.date,
      required this.tempEmotion,
      required this.curDates})
      : super(key: key);
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
    Map curInfo = widget.curDates[widget.date.day];
    String curEmotion = curInfo["emotion"];
    String curId = curInfo["id"];

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
                        log("It's here");
                        widget.setNavBarUp(true);
                        widget.setEmotionSelectorUp(false);
                        widget.setInputEmotionUp(false);
                      },
                    )))),
        EmotionWrapper(
            setInputEmotionUp: widget.setInputEmotionUp,
            setEmotionSelectorUp: widget.setEmotionSelectorUp,
            emotionSelectorUp: widget.emotionSelectorUp,
            date: widget.date,
            emotion: curEmotion,
            id: curId,
            curDates: widget.curDates)
      ]),
    );
  }
}

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper({
    Key? key,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
    required this.emotionSelectorUp,
    required this.date,
    required this.emotion,
    required this.id,
    required this.curDates,
  }) : super(key: key);
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final bool emotionSelectorUp;
  final String? id;
  final DateTime date;
  final String? emotion;
  final Map curDates;
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
                      widget.emotion,
                      widget.setEmotionSelectorUp,
                      widget.setInputEmotionUp,
                      widget.curDates,
                      context)),
            ),
          ],
        ));
  }
}

List<Widget> EmoticonList(
    String? emotion,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    Map curDates,
    BuildContext context) {
  if (emotion == null) {
    return [];
  }
  log(emotion);
  List<String> curList = ImoticonLink[emotion];
  List<Widget> curWidgets = [];
  for (String str in curList) {
    curWidgets.add(ButtonWrapper(
        setEmotionSelectorUp: setEmotionSelectorUp,
        setInputEmotionUp: setInputEmotionUp,
        emotion: str));
    // IconButton(
    // padding: EdgeInsets.all(0),
    // onPressed: () {
    //   setEmotionSelectorUp(false);
    //   setInputEmotionUp(false);
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => EmotionResult()));
    // },
    // icon: Image.asset(height: 50, width: 50, str)));
  }
  return curWidgets;
}

class ButtonWrapper extends StatefulWidget {
  const ButtonWrapper(
      {Key? key,
      required this.setEmotionSelectorUp,
      required this.setInputEmotionUp,
      required this.emotion})
      : super(key: key);
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setInputEmotionUp;
  final String emotion;
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
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => EmotionResult()));
        },
        icon: Image.asset(height: 50, width: 50, widget.emotion));
  }
}
