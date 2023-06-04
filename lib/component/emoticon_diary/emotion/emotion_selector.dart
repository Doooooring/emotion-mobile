import 'dart:ui';

import "package:aeye/services/emotion.dart";
import 'package:flutter/material.dart';

EmotionServices emotionServices = new EmotionServices();

class SelectorWrapper extends StatefulWidget {
  const SelectorWrapper(
      {Key? key,
      required this.date,
      required this.tempEmotion,
      required this.curDates,
      required this.emotionSelectorUp,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.imageHeight})
      : super(key: key);
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  final bool emotionSelectorUp;
  final DateTime date;
  final String? tempEmotion;
  final Map curDates;
  final double imageHeight;

  @override
  State<SelectorWrapper> createState() => _SelectorWrapperState();
}

class _SelectorWrapperState extends State<SelectorWrapper> {
  @override
  Widget build(BuildContext context) {
    Map curInfo = widget.curDates[widget.date.day.toString()];
    int? curId = curInfo["id"];

    return Offstage(
      offstage: widget.emotionSelectorUp != true,
      child: Container(
        width: double.infinity,
        height: 800,
        child: Stack(children: [
          ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      child: GestureDetector(
                        onTap: () {
                          widget.setEmotionSelectorUp(false);
                          widget.setInputEmotionUp(false);
                        },
                      )))),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: 0,
            top: widget.emotionSelectorUp ? 500 : 700,
            child: EmotionWrapper(
                id: curId,
                date: widget.date,
                emotion: widget.tempEmotion,
                curDates: widget.curDates,
                emotionSelectorUp: widget.emotionSelectorUp,
                setIsLoading: widget.setIsLoading,
                setCurDate: widget.setCurDate,
                setInputEmotionUp: widget.setInputEmotionUp,
                setEmotionSelectorUp: widget.setEmotionSelectorUp,
                imageHeight: widget.imageHeight),
          )
        ]),
      ),
    );
  }
}

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper(
      {Key? key,
      required this.id,
      required this.date,
      required this.emotion,
      required this.curDates,
      required this.emotionSelectorUp,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.imageHeight})
      : super(key: key);

  final int? id;
  final DateTime date;
  final String? emotion;
  final Map curDates;
  final bool emotionSelectorUp;
  final double imageHeight;
  final void Function(bool) setIsLoading;
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
        width: MediaQuery.of(context).size.width,
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
                      Text("Choose Emoji!", style: (TextStyle(fontSize: 18)))
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
                      widget.emotionSelectorUp,
                      widget.setIsLoading,
                      widget.setCurDate,
                      widget.setInputEmotionUp,
                      widget.setEmotionSelectorUp,
                      widget.imageHeight,
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
    bool emotionSelectorUp,
    void Function(bool) setIsLoading,
    void Function(String, int?, String?, String?) setCurDate,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    double imageHeight,
    BuildContext context) {
  if (emotion == null) {
    return [];
  }
  List<String> curList = [
    '${emotion}-1',
    '${emotion}-2',
    '${emotion}-3',
    '${emotion}-4'
  ];
  List<Widget> curWidgets = [];
  for (String str in curList) {
    curWidgets.add(ButtonWrapper(
        id: id,
        emotionSelectorUp: emotionSelectorUp,
        setIsLoading: setIsLoading,
        setEmotionSelectorUp: setEmotionSelectorUp,
        setInputEmotionUp: setInputEmotionUp,
        setCurDate: setCurDate,
        imageHeight: imageHeight,
        emotion: str,
        date: date));
  }
  return curWidgets;
}

class ButtonWrapper extends StatefulWidget {
  const ButtonWrapper({
    Key? key,
    required this.id,
    required this.emotionSelectorUp,
    required this.date,
    required this.emotion,
    required this.setIsLoading,
    required this.setCurDate,
    required this.imageHeight,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final int? id;
  final bool emotionSelectorUp;
  final DateTime date;
  final String emotion;
  final double imageHeight;
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  @override
  State<ButtonWrapper> createState() => _ButtonWrapperState();
}

class _ButtonWrapperState extends State<ButtonWrapper> {
  @override
  Widget build(BuildContext context) {
    double maxHeight = 90;

    return Transform.translate(
      offset: Offset(0, widget.imageHeight - maxHeight),
      child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () async {
            widget.setIsLoading(true);
            bool state = await emotionServices.reviseEmotion(
                widget.id,
                widget.emotion,
                widget.date,
                widget.setEmotionSelectorUp,
                widget.setInputEmotionUp,
                widget.setCurDate);
            print(state);
            widget.setIsLoading(false);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => EmotionResult()));
          },
          icon: Image.asset(
              height: 50, width: 50, 'assets/images/${widget.emotion}.png')),
    );
  }
}
