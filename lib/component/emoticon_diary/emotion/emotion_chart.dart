import 'package:flutter/material.dart';

import "../../../asset/imoticon_url.dart";

class EmotionChart extends StatefulWidget {
  const EmotionChart(
      {Key? key,
      required this.date,
      required this.curDates,
      required this.setEmotionSelectorUp})
      : super(key: key);
  final Map curDates;
  final DateTime date;
  final void Function(bool) setEmotionSelectorUp;
  @override
  State<EmotionChart> createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  @override
  Widget build(BuildContext context) {
    Map selected = widget.curDates[widget.date.day.toString()];
    String image = ImageLink[selected["emotion"]];

    bool state = selected["id"] == null;
    return Container(
        width: 80,
        height: 80,
        child: IconButton(
            onPressed: () {
              if (state == true) {
                //toast 띄우기
                return;
              }
              widget.setEmotionSelectorUp(true);
            },
            icon: Image.asset(image)));
  }
}
