import "package:aeye/services/emotion.dart";
import 'package:flutter/material.dart';

var EmotionService = new EmotionServices();

class EmotionHandleButton extends StatefulWidget {
  const EmotionHandleButton(
      {Key? key,
      required this.curDates,
      required this.inputText,
      required this.dateSelected,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setIsChanged,
      required this.setCurTempEmotion,
      required this.setEmotionSelectorUp})
      : super(key: key);
  final Map curDates;
  final String inputText;
  final DateTime dateSelected;
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setIsChanged;
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

    return TextButton(
        child: const Text("SAVE", style: TextStyle(color: Colors.black)),
        onPressed: () async {
          widget.setIsChanged(false);
          widget.setIsLoading(true);
          bool apiState = await EmotionService.saveDiaryText(
              curId,
              widget.dateSelected,
              widget.inputText,
              widget.setCurDate,
              widget.setCurTempEmotion);
          widget.setEmotionSelectorUp(true);
          widget.setIsLoading(false);
        });
  }
}
