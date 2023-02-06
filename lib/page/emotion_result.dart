import "dart:math" as math;

import 'package:flutter/material.dart';

import "../asset/imoticon_url.dart";

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

class EmotionResult extends StatelessWidget {
  const EmotionResult(
      {Key? key,
      required this.date,
      required this.emotion,
      required this.emotionText,
      required this.sentimentLevel,
      required this.recommend})
      : super(key: key);

  final DateTime date;
  final String? emotion;
  final String emotionText;
  final double sentimentLevel;
  final String recommend;

  @override
  Widget build(BuildContext context) {
    String month = Month[date.month.toString()];
    String emotionLink = ImageLink[emotion];
    String emotionState = sentimentLevel > 3.3
        ? "Positive"
        : sentimentLevel > 1.6
            ? "Neutral"
            : "Negaitve";
    Color stateColor = sentimentLevel > 3.3
        ? Color(0xff4FB699)
        : sentimentLevel > 1.6
            ? Color(0xffFFB600)
            : Colors.red;
    double rotateAngle = math.pi * (sentimentLevel - 2.5) / 5;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: Color(0xffFFF6DA),
          elevation: 0,
          flexibleSpace: Column(children: [
            SizedBox(height: 80),
            Text("Daily Report",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                )),
            SizedBox(height: 15),
            Text("${month} ${date.day.toString()} ${date.year}",
                style: TextStyle(color: Colors.grey, fontSize: 15))
          ])),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            width: double.infinity,
            color: Color(0xffFFF6DA),
            child: Column(children: [
              Container(
                  child: Column(children: [
                SizedBox(height: 20),
                Image.asset(emotionLink, width: 90),
                SizedBox(height: 10),
                Text(emotionText, style: TextStyle(fontSize: 20))
              ])),
              SizedBox(height: 20),
              Container(
                  width: 340,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sentiment Level", style: TextStyle(fontSize: 25)),
                        SizedBox(height: 20),
                        Container(
                            height: 300,
                            child: Stack(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      height: 280,
                                      "assets/images/sentimentalLevelBoard.png"),
                                ],
                              ),
                              Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Container(
                                      height: 277,
                                    ),
                                    Transform.rotate(
                                      angle: rotateAngle,
                                      child: Container(
                                        height: 160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 19),
                                            Container(
                                              height: 70,
                                              child: Image.asset(
                                                  "assets/images/needle.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ])),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 300, height: 160),
                                    SizedBox(
                                        child: Text.rich(TextSpan(
                                      text: '', // default text style
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: sentimentLevel.toString(),
                                            style: TextStyle(fontSize: 35)),
                                        TextSpan(
                                            text: '/5',
                                            style: TextStyle(fontSize: 25)),
                                      ],
                                    ))),
                                    Text(emotionState,
                                        style: TextStyle(
                                            color: stateColor, fontSize: 45))
                                  ],
                                ),
                              )
                            ])),
                      ])),
              SizedBox(height: 20),
              Container(
                  width: 340,
                  height: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(recommend)),
            ])),
      ),
    );
  }
}
