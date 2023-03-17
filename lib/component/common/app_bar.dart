import "package:aeye/controller/routeController.dart";
import 'package:aeye/page/emotion/emoticon_month_result.dart';
import "package:aeye/services/emotion.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

EmotionServices emotionService = new EmotionServices();

AppBar Header(DateTime? curDate) {
  final RouteController routeController = Get.find();
  final String curPath = routeController.curPath.toString();

  final String title = curPath == "emotionDiary" ? "Diary" : "Baby Monitor";

  if (curPath == "init") {
    return AppBar(
        backgroundColor: Color(0xffFFF7DF),
        elevation: 0.5,
        centerTitle: false,
        title: SizedBox(
          child: Row(
            children: const [
              SizedBox(width: 10),
              Text("A-eye",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                    size: 30, Icons.keyboard_control, color: Colors.black)),
            iconSize: 40,
            onSelected: (result) {},
            itemBuilder: (BuildContext context) => []
                .map((value) => PopupMenuItem(
                      value: value,
                      child: Text(value.toShortString()),
                    ))
                .toList(),
          ),
          SizedBox(width: 10)
        ]);
  }

  return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            routeController.toInit();
            Navigator.pop(context);
            return;
          },
        );
      }),
      backgroundColor: Color(0xffFFF7DF),
      elevation: 1.0,
      centerTitle: false,
      title: SizedBox(
        child: Row(
          children: [
            Text(title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      actions: [
        curDate != null
            ? MonthResultButton(curDate: curDate)
            : SizedBox(width: 0),
        PopupMenuButton(
          icon: RotatedBox(
              quarterTurns: 1,
              child:
                  Icon(size: 30, Icons.keyboard_control, color: Colors.black)),
          iconSize: 40,
          onSelected: (result) {},
          itemBuilder: (BuildContext context) => []
              .map((value) => PopupMenuItem(
                    value: value,
                    child: Text(value.toShortString()),
                  ))
              .toList(),
        ),
        SizedBox(width: 10)
      ]);
}

class MonthResultButton extends StatefulWidget {
  const MonthResultButton({Key? key, required this.curDate}) : super(key: key);

  final DateTime curDate;

  @override
  State<MonthResultButton> createState() => _MonthResultButtonState();
}

class _MonthResultButtonState extends State<MonthResultButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset("assets/images/heartemoticon.png"),
      onPressed: () async {
        Map response = {
          "sentimentLevel": {"positive": 16, "neutral": 2, "negative": 10},
          "emotionHistogram": {
            "excited": 7,
            "happy": 3,
            "calm": 2,
            "content": 2,
            "anticipate": 2,
            "tense": 1,
            "angry": 2,
            "sad": 2,
            "badSurprised": 4,
            "goodSurprised": 1,
            "relaxed": 1,
            "bored": 0,
            "tired": 1,
            "mostFrequentEmotion": "excited" //이건 무시해죠..
          },
          "monthlyEmotion": {
            "emotion": "excited",
            "comment": "You had a wonderful day!"
          }
        };

        // await emotionService.getMonthlyResult(
        //     widget.curDate.year, widget.curDate.month);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmoticonMonthResult(
                    year: widget.curDate.year,
                    month: widget.curDate.month,
                    data: response)));
      },
    );
  }
}
