import 'package:flutter/material.dart';

// import "package:fluttertoast/fluttertoast.dart";

import "../../../asset/imoticon_url.dart";
import "../../../services/emotion.dart";

EmotionServices emotionServices = EmotionServices();

class EmotionChart extends StatefulWidget {
  const EmotionChart(
      {Key? key,
      required this.date,
      required this.curDates,
      required this.isChanged,
      required this.setEmotionSelectorUp,
      required this.setCurTempEmotion})
      : super(key: key);
  final Map curDates;
  final DateTime date;
  final bool isChanged;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(String?) setCurTempEmotion;
  @override
  State<EmotionChart> createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  @override
  Widget build(BuildContext context) {
    Map selected = widget.curDates[widget.date.day.toString()];

    String emoticon = selected["emotion"] ?? "assets/images/mean.png";

    String image = widget.isChanged ? ImageLink[null] : emoticon;

    bool state = selected["id"] == null; //이모티콘 없는 상태

    return Container(
        width: 80,
        height: 80,
        child: IconButton(
            onPressed: () {
              if (state == true) {
                // flutterToast();
                return;
              }
              // tempemotion 받아오기
              int curId = selected["id"];
              emotionServices.reviseTempEmotion(
                  curId, widget.setCurTempEmotion, widget.setEmotionSelectorUp);
              widget.setEmotionSelectorUp(true);
            },
            icon: Image.asset(image)));
  }
}

void flutterToast() {
  // 토스트 메시지를 출력하기 위한 함수 생성
  // Fluttertoast.showToast(
  //     msg: 'Flutter 토스트 메시지', // 토스트 메시지 내용
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.redAccent, // 배경색 빨강색
  //     fontSize: 20.0,
  //     textColor: Colors.white, // 폰트 하얀색
  //     toastLength: Toast.LENGTH_SHORT // 토스트 메시지 지속시간 짧게
  // );
}
