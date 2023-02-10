import 'package:flutter/material.dart';

import "../../../services/emotion.dart";

var EmotionService = new EmotionServices();

Map ImageLink = {
  "null": "assets/images/mean.png",
  "angry": "assets/images/angry.png",
  "anticipate": "assets/images/anticipate.png",
  "bored": "assets/images/bored.png",
  "calm": "assets/images/calm.png",
  "content": "assets/images/content.png",
  "excited": "assets/images/excited.png",
  "happy": "assets/images/happy.png",
  "relaxed": "assets/images/relaxed.png",
  "sad": "assets/images/sad.png",
  "surprised(bad reason)": "assets/images/surprised(bad).png",
  "surprised(good reason)": "assets/images/surprised(good).png",
  "tense": "assets/images/tense.png",
  "tired": "assets/images/tired.png"
};

class EmotionHandleButton extends StatefulWidget {
  const EmotionHandleButton(
      {Key? key,
      required this.curDates,
      required this.inputText,
      required this.dateSelected,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setCurTempEmotion,
      required this.setEmotionSelectorUp})
      : super(key: key);
  final Map curDates;
  final String inputText;
  final DateTime dateSelected;
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(String?) setCurTempEmotion;
  final void Function(bool) setEmotionSelectorUp;
  @override
  State<EmotionHandleButton> createState() => _EmotionHandleButtonState();
}

class _EmotionHandleButtonState extends State<EmotionHandleButton> {
  @override
  Widget build(BuildContext context) {
    Map curDates = widget.curDates;
    DateTime curDate = widget.dateSelected;
    Map curInfo = curDates[curDate.day.toString()];
    int? curId = curInfo['id'];

    return IconButton(
        icon: const Icon(Icons.send),
        onPressed: () async {
          widget.setIsLoading(false);
          EmotionService.saveDiaryText(
              curId,
              widget.dateSelected,
              widget.inputText,
              widget.setCurDate,
              widget.setEmotionSelectorUp,
              widget.setCurTempEmotion);
          widget.setIsLoading(true);
        });
  }
}
