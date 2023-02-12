import 'package:flutter/material.dart';

import "../../common/loading.dart";
import 'emotion_chart.dart';
import 'emotion_handle_button.dart';
import 'emotion_head.dart';
import 'emotion_input.dart';

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper(
      {Key? key,
      required this.textController,
      required this.curDates,
      required this.dateSelected,
      required this.emotionSelectorUp,
      required this.setCurDate,
      required this.setInputEmotionUp,
      required this.setCurTempEmotion,
      required this.setEmotionSelectorUp})
      : super(key: key);
  final TextEditingController textController;
  final Map curDates;
  final DateTime dateSelected;
  final bool emotionSelectorUp;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(String?) setCurTempEmotion;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  @override
  State<EmotionWrapper> createState() => _EmotionWrapperState();
}

class _EmotionWrapperState extends State<EmotionWrapper> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 800,
        decoration: BoxDecoration(
          //style 느낌
          color: Colors.white,
        ),
        child: Stack(children: [
          EmotionContainer(
              textController: widget.textController,
              curDates: widget.curDates,
              dateSelected: widget.dateSelected,
              setInputEmotionUp: widget.setInputEmotionUp,
              setCurDate: widget.setCurDate,
              setEmotionSelectorUp: widget.setEmotionSelectorUp,
              setCurTempEmotion: widget.setCurTempEmotion),
        ]),
      ),
    );
  }
}

class EmotionContainer extends StatefulWidget {
  const EmotionContainer(
      {Key? key,
      required this.textController,
      required this.curDates,
      required this.setInputEmotionUp,
      required this.dateSelected,
      required this.setCurDate,
      required this.setEmotionSelectorUp,
      required this.setCurTempEmotion})
      : super(key: key);
  final TextEditingController textController;
  final Map curDates;
  final void Function(bool) setInputEmotionUp;
  final DateTime dateSelected;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(String?) setCurTempEmotion;

  @override
  State<EmotionContainer> createState() => _EmotionContainerState();
}

class _EmotionContainerState extends State<EmotionContainer> {
  @override
  String inputText = '';
  void setInputText(String text) {
    setState(() {
      inputText = text;
    });
  }

  bool isChanged = false;
  void setIsChanged(state) {
    setState(() {
      isChanged = state;
    });
  }

  bool isLoading = true;
  void setIsLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Stack(
          children: [
            Column(children: <Widget>[
              SizedBox(height: 30),
              EmotionHead(
                  date: widget.dateSelected,
                  setInputEmotionUp: widget.setInputEmotionUp),
              SizedBox(height: 30),
              EmotionChart(
                  date: widget.dateSelected,
                  curDates: widget.curDates,
                  isChanged: isChanged,
                  setEmotionSelectorUp: widget.setEmotionSelectorUp,
                  setCurTempEmotion: widget.setCurTempEmotion),
              SizedBox(
                child: Column(children: <Widget>[
                  EmotionInput(
                      textController: widget.textController,
                      date: widget.dateSelected,
                      curDates: widget.curDates,
                      inputText: inputText,
                      setInputText: setInputText,
                      setIsChanged: setIsChanged)
                ]),
              ),
              SizedBox(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  EmotionHandleButton(
                      curDates: widget.curDates,
                      inputText: inputText,
                      dateSelected: widget.dateSelected,
                      setIsLoading: setIsLoading,
                      setCurDate: widget.setCurDate,
                      setCurTempEmotion: widget.setCurTempEmotion,
                      setEmotionSelectorUp: widget.setEmotionSelectorUp)
                ]),
              )
            ]),
            Loading(isLoading: isLoading, height: 800),
          ],
        ),
      ),
    );
  }
}
