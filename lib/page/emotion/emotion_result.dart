import "dart:math" as math;

import 'package:flutter/material.dart';

import '../../component/common/youtube_player.dart';

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

class DailReport extends StatefulWidget {
  const DailReport(
      {Key? key,
      required this.date,
      required this.emotion,
      required this.emotionText,
      required this.sentimentLevel,
      required this.videoUrl,
      required this.title})
      : super(key: key);

  final DateTime date;
  final String? emotion;
  final String emotionText;
  final double sentimentLevel;
  final String videoUrl;
  final String title;

  @override
  State<DailReport> createState() => _DailReportState();
}

class _DailReportState extends State<DailReport> {
  @override
  Widget build(BuildContext context) {
    String month = Month[widget.date.month.toString()];
    String emotionLink = widget.emotion == null
        ? "assets/images/mean.png"
        : 'assets/images/${widget.emotion}.png';
    String emotionState = widget.sentimentLevel > 3.3
        ? "Positive"
        : widget.sentimentLevel > 1.6
            ? "Neutral"
            : "Negaitve";
    Color stateColor = widget.sentimentLevel > 3.3
        ? Color(0xff4FB699)
        : widget.sentimentLevel > 1.6
            ? Color(0xffFFB600)
            : Colors.red;
    double rotateAngle = math.pi * (widget.sentimentLevel - 2.5) / 5;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.arrow_back_ios, color: Colors.black),
              ],
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          scrolledUnderElevation: 1,
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
            Text("${month} ${widget.date.day.toString()} ${widget.date.year}",
                style: TextStyle(color: Colors.grey, fontSize: 15))
          ])),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
            width: double.infinity,
            color: Color(0xffFFF6DA),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Column(children: [
                    SizedBox(height: 20),
                    Image.asset(emotionLink, width: 90),
                    SizedBox(height: 10),
                    Text(widget.emotionText, style: TextStyle(fontSize: 20))
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
                                            SizedBox(height: 27),
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
                                            text: widget.sentimentLevel
                                                .toString(),
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
                padding:
                    EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Text("Playlist for your mood",
                        style: TextStyle(fontSize: 25)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note, size: 20, color: Colors.grey),
                        Text(widget.title,
                            style: TextStyle(color: Colors.grey, fontSize: 10))
                      ],
                    ),
                    SizedBox(height: 15),
                    Player(widget.videoUrl, 250),
                  ],
                ),
              ),
              SizedBox(height: 300)
            ])),
      ),
    );
  }
}

class EmotionResult extends StatelessWidget {
  const EmotionResult(
      {Key? key,
      required this.date,
      required this.emotion,
      required this.emotionText,
      required this.sentimentLevel,
      required this.videoUrl,
      required this.title})
      : super(key: key);

  final DateTime date;
  final String? emotion;
  final String emotionText;
  final double sentimentLevel;
  final String videoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    String month = Month[date.month.toString()];
    String emotionLink = emotion == null
        ? "assets/images/mean.png"
        : 'assets/images/${emotion}.png';
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
          leading: IconButton(
            icon: Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.arrow_back_ios, color: Colors.black),
              ],
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          scrolledUnderElevation: 1,
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
        physics: ClampingScrollPhysics(),
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
                                            SizedBox(height: 27),
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
                padding:
                    EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Text("Playlist for your mood",
                        style: TextStyle(fontSize: 25)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note, size: 20, color: Colors.grey),
                        Text(title,
                            style: TextStyle(color: Colors.grey, fontSize: 10))
                      ],
                    ),
                    SizedBox(height: 15),
                    Player(videoUrl, 250),
                  ],
                ),
              ),
              SizedBox(height: 300)
            ])),
      ),
    );
  }
}
