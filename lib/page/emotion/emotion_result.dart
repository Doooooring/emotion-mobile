import "dart:math" as math;
import "dart:math";

import "package:aeye/component/common/loading_proto.dart";
import 'package:aeye/component/common/youtube_player.dart';
import 'package:aeye/services/emotion.dart';
import 'package:flutter/material.dart';

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

class DailyReportWrapper extends StatefulWidget {
  const DailyReportWrapper({Key? key, required this.id, required this.date})
      : super(key: key);

  final int id;
  final DateTime date;

  @override
  State<DailyReportWrapper> createState() => _DailyReportWrapperState();
}

class _DailyReportWrapperState extends State<DailyReportWrapper> {
  EmotionServices emotionServices = EmotionServices();

  Map? data = null;
  void setData(Map newData) {
    setState(() {
      data = newData;
    });
  }

  _asyncMethod() async {
    Map response = await emotionServices.getResultPage(widget.id, widget.date);
    setData(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _asyncMethod();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Loading(isLoading: true, height: MediaQuery.of(context).size.height)
        : DailReport(
            date: data!["date"],
            emotion: data!["emotion"],
            emotionText: data!["emotionText"],
            sentimentLevel: data!["sentimentLevel"],
            videoUrl: data!["videoUrl"],
            title: data!["title"]);
  }
}

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

class _DailReportState extends State<DailReport> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
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
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double curValue = _animation.value;

    double xForHeight =
        curValue < 0.2 ? curValue * 5 : (curValue - 0.6).abs() + 0.6;

    double maxHeight = 30;
    double curHeight = maxHeight * pow(xForHeight, 1.5);

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
    double rotateAngle =
        math.pi * (widget.sentimentLevel * xForHeight - 2.5) / 5;

    double sentimentLevel = widget.sentimentLevel * curValue;

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
                    Transform.translate(
                        offset: Offset(0, -30 + curHeight),
                        child: Image.asset(emotionLink, width: 90)),
                    SizedBox(height: 10),
                    Text(widget.emotionText,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600))
                  ])),
              SizedBox(height: 30),
              Container(
                  width: 340,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sentiment Level",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                        SizedBox(height: 20),
                        Container(
                            height: 300,
                            child: Stack(children: [
                              SizedBox(
                                height: 280,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 5 * min(0.2, curValue),
                                      child: Image.asset(
                                          height: 280,
                                          "assets/images/sentimentalLevelBoard.png"),
                                    ),
                                  ],
                                ),
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
                                      children: [
                                        TextSpan(
                                            text: sentimentLevel
                                                .toStringAsFixed(1),
                                            style: TextStyle(fontSize: 35)),
                                        TextSpan(
                                            text: '/5',
                                            style: TextStyle(fontSize: 25)),
                                      ],
                                    ))),
                                    Opacity(
                                      opacity: curValue < 0.8
                                          ? 0
                                          : (curValue - 0.8) * 5,
                                      child: Text(emotionState,
                                          style: TextStyle(
                                              color: stateColor, fontSize: 45)),
                                    )
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

//
// class EmotionResult extends StatelessWidget {
//   const EmotionResult(
//       {Key? key,
//       required this.date,
//       required this.emotion,
//       required this.emotionText,
//       required this.sentimentLevel,
//       required this.videoUrl,
//       required this.title})
//       : super(key: key);
//
//   final DateTime date;
//   final String? emotion;
//   final String emotionText;
//   final double sentimentLevel;
//   final String videoUrl;
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     String month = Month[date.month.toString()];
//     String emotionLink = emotion == null
//         ? "assets/images/mean.png"
//         : 'assets/images/${emotion}.png';
//     String emotionState = sentimentLevel > 3.3
//         ? "Positive"
//         : sentimentLevel > 1.6
//             ? "Neutral"
//             : "Negaitve";
//     Color stateColor = sentimentLevel > 3.3
//         ? Color(0xff4FB699)
//         : sentimentLevel > 1.6
//             ? Color(0xffFFB600)
//             : Colors.red;
//     double rotateAngle = math.pi * (sentimentLevel - 2.5) / 5;
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             icon: Row(
//               children: [
//                 SizedBox(width: 15),
//                 Icon(Icons.arrow_back_ios, color: Colors.black),
//               ],
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           scrolledUnderElevation: 1,
//           toolbarHeight: 120,
//           backgroundColor: Color(0xffFFF6DA),
//           elevation: 0,
//           flexibleSpace: Column(children: [
//             SizedBox(height: 80),
//             Text("Daily Report",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 30,
//                 )),
//             SizedBox(height: 15),
//             Text("${month} ${date.day.toString()} ${date.year}",
//                 style: TextStyle(color: Colors.grey, fontSize: 15))
//           ])),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: ClampingScrollPhysics(),
//         child: Container(
//             width: double.infinity,
//             color: Color(0xffFFF6DA),
//             child: Column(children: [
//               Container(
//                   child: Column(children: [
//                 SizedBox(height: 20),
//                 Image.asset(emotionLink, width: 90),
//                 SizedBox(height: 10),
//                 Text(emotionText, style: TextStyle(fontSize: 20))
//               ])),
//               SizedBox(height: 20),
//               Container(
//                   width: 340,
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(40)),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Sentiment Level", style: TextStyle(fontSize: 25)),
//                         SizedBox(height: 20),
//                         Container(
//                             height: 300,
//                             child: Stack(children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                       height: 280,
//                                       "assets/images/sentimentalLevelBoard.png"),
//                                 ],
//                               ),
//                               Container(
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                     Container(
//                                       height: 277,
//                                     ),
//                                     Transform.rotate(
//                                       angle: rotateAngle,
//                                       child: Container(
//                                         height: 160,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             SizedBox(height: 27),
//                                             Container(
//                                               height: 70,
//                                               child: Image.asset(
//                                                   "assets/images/needle.png"),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ])),
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SizedBox(width: 300, height: 160),
//                                     SizedBox(
//                                         child: Text.rich(TextSpan(
//                                       text: '', // default text style
//                                       children: <TextSpan>[
//                                         TextSpan(
//                                             text: sentimentLevel.toString(),
//                                             style: TextStyle(fontSize: 35)),
//                                         TextSpan(
//                                             text: '/5',
//                                             style: TextStyle(fontSize: 25)),
//                                       ],
//                                     ))),
//                                     Text(emotionState,
//                                         style: TextStyle(
//                                             color: stateColor, fontSize: 45))
//                                   ],
//                                 ),
//                               )
//                             ])),
//                       ])),
//               SizedBox(height: 20),
//               Container(
//                 width: 340,
//                 height: 300,
//                 padding:
//                     EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40)),
//                 child: Column(
//                   children: [
//                     Text("Playlist for your mood",
//                         style: TextStyle(fontSize: 25)),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.music_note, size: 20, color: Colors.grey),
//                         Text(title,
//                             style: TextStyle(color: Colors.grey, fontSize: 10))
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Player(videoUrl, 250),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 300)
//             ])),
//       ),
//     );
//   }
// }
