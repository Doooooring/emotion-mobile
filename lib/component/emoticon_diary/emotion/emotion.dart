import "dart:math";

import "package:aeye/component/common/loading_proto.dart";
import 'package:flutter/material.dart';

import 'emotion_chart.dart';
import 'emotion_head.dart';
import 'emotion_input.dart';
import "emotion_selector.dart";

class EmotionWrapper extends StatefulWidget {
  const EmotionWrapper(
      {Key? key,
      required this.textController,
      required this.curDates,
      required this.setInputEmotionUp,
      required this.dateSelected,
      required this.curTempEmotion,
      required this.emotionSelectorUp,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setEmotionSelectorUp,
      required this.setCurTempEmotion})
      : super(key: key);
  final Map<String, Map> curDates;
  final DateTime dateSelected;
  final TextEditingController textController;
  final String? curTempEmotion;
  final bool emotionSelectorUp;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(String?) setCurTempEmotion;

  @override
  State<EmotionWrapper> createState() => _EmotionWrapperState();
}

class _EmotionWrapperState extends State<EmotionWrapper>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  bool isLoading = false;
  void setIsLoading(bool state) {
    if (!state) {
      setState(() {
        isLoading = state;
        _controller.forward();
      });
    } else {
      setState(() {
        isLoading = state;
        _controller.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double curValue = _animation.value;
    double maxHeight = 50;
    double imageHeight = max(curValue * 100, maxHeight);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 800,
        decoration: BoxDecoration(color: Colors.white),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: double.infinity,
            height: 800,
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
                      curDates: widget.curDates,
                      inputText: inputText,
                      dateSelected: widget.dateSelected,
                      setIsLoading: setIsLoading,
                      setCurDate: widget.setCurDate,
                      setCurTempEmotion: widget.setCurTempEmotion,
                      setEmotionSelectorUp: widget.setEmotionSelectorUp,
                      setIsChanged: setIsChanged,
                      setInputEmotionUp: widget.setInputEmotionUp),
                  SizedBox(height: 30),
                  EmotionChart(
                      date: widget.dateSelected,
                      curDates: widget.curDates,
                      isChanged: isChanged,
                      setIsLoading: setIsLoading,
                      setEmotionSelectorUp: widget.setEmotionSelectorUp,
                      setCurTempEmotion: widget.setCurTempEmotion),
                  SizedBox(
                    width: double.infinity,
                    child: Column(children: <Widget>[
                      EmotionInput(
                          textController: widget.textController,
                          date: widget.dateSelected,
                          curDates: widget.curDates,
                          inputText: inputText,
                          setInputText: setInputText,
                          setIsChanged: setIsChanged)
                    ]),
                  )
                ]),
                SelectorWrapper(
                    date: widget.dateSelected,
                    tempEmotion: widget.curTempEmotion,
                    curDates: widget.curDates,
                    setCurDate: widget.setCurDate,
                    emotionSelectorUp: widget.emotionSelectorUp,
                    setInputEmotionUp: widget.setInputEmotionUp,
                    setEmotionSelectorUp: widget.setEmotionSelectorUp,
                    setIsLoading: widget.setIsLoading,
                    imageHeight: imageHeight),
                Loading(isLoading: isLoading, height: 800),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
