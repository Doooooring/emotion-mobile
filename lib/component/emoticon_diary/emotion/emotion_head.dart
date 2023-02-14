import 'package:firstproject/component/emoticon_diary/emotion/emotion_handle_button.dart';
import "package:flutter/material.dart";

Map Month = {
  "1": "Jan",
  "2": "Feb",
  "3": "Mar",
  "4": "Apr",
  "5": "May",
  "6": "Jun",
  "7": "Jul",
  "8": "Aug",
  "9": "Sep",
  "10": "Oct",
  "11": "Nov",
  "12": "Dec"
};

class EmotionHead extends StatefulWidget {
  const EmotionHead(
      {Key? key,
      required this.date,
      required this.curDates,
      required this.inputText,
      required this.dateSelected,
      required this.setIsLoading,
      required this.setCurDate,
      required this.setCurTempEmotion,
      required this.setEmotionSelectorUp,
      required this.setIsChanged,
      required this.setInputEmotionUp})
      : super(key: key);
  final DateTime date;
  final Map curDates;
  final String inputText;
  final DateTime dateSelected;
  final void Function(bool) setIsLoading;
  final void Function(String, int?, String?, String?) setCurDate;
  final void Function(bool) setIsChanged;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(String?) setCurTempEmotion;

  @override
  State<EmotionHead> createState() => _EmotionHeadState();
}

class _EmotionHeadState extends State<EmotionHead> {
  @override
  Widget build(BuildContext context) {
    String month = Month[widget.date.month.toString()];
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 100,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.0,
                child: IconButton(
                    onPressed: () {
                      widget.setIsChanged(false);
                      widget.setInputEmotionUp(false);
                    },
                    icon: Image.asset('assets/images/ico_close.png')),
              ),
              SizedBox(width: 60),
              SizedBox(
                  width: 60,
                  child: EmotionHandleButton(
                      curDates: widget.curDates,
                      inputText: widget.inputText,
                      dateSelected: widget.dateSelected,
                      setIsLoading: widget.setIsLoading,
                      setCurDate: widget.setCurDate,
                      setIsChanged: widget.setIsChanged,
                      setCurTempEmotion: widget.setCurTempEmotion,
                      setEmotionSelectorUp: widget.setEmotionSelectorUp))
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.date.year} ${month} ${widget.date.day}',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
