import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:url_launcher/url_launcher.dart';

import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../component/common/youtube_player.dart";
import "../controller/sizeController.dart";
import 'login/login.dart';

final dio = Dio();

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

List<Map> recommendList = [
  {
    "title": "Ready to Snap? Tips for Stressed-Out Parents",
    "link":
        "https://health.clevelandclinic.org/ready-snap-tips-for-stressed-out-parents/",
    "imgLink": "assets/images/recommend1.png"
  },
  {
    "title": "What is independent sleep? A guide to self settling.",
    "link":
        "[https://justchillbabysleep.co.uk/2021/04/20/what-is-independent-sleep-a-guide-to-self-settling/](https://justchillbabysleep.co.uk/2021/04/20/what-is-independent-sleep-a-guide-to-self-settling/)",
    "imgLink": "assets/images/recommend2.png"
  },
  {
    "title": "Positive Parenting Tips",
    "link":
        "https://www.cdc.gov/ncbddd/childdevelopment/positiveparenting/index.html ",
    "imgLink": "assets/images/recommend6.png"
  },
  {
    "title": "Best ways Dads can help a new mom",
    "link": "https://www.baby-chick.com/how-dads-can-help-a-new-mom",
    "imgLink": "assets/images/recommend4.png"
  },
  {
    "title": "When Your Baby Won’t Stop Crying",
    "link":
        "https://www.helpguide.org/articles/parenting-family/when-your-baby-wont-stop-crying.htm",
    "imgLink": "assets/images/recommend5.png"
  },
  {
    "title": "How to Help Your Child Build Social Skills",
    "link":
        "https://childdevelopmentinfo.com/ages-stages/school-age-children-development-parenting-tips/social-skills/",
    "imgLink": "assets/images/recommend6.png"
  },
];

class InitialPage extends StatelessWidget {
  final bool isAlert = Get.find();

  InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int month = today.month;
    int day = today.day;
    int hour = today.hour;

    String monthToStr = Month[month.toString()];
    String title = "How are you today?";
    String? video = "0qaL2Im4fWY";

    return Scaffold(
      appBar: Header(null, "init"),
      body: Column(children: [
        Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 18.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 6))
                ],
                color: Color(0xffFFF7DF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            padding: EdgeInsets.only(
                left: scaleWidth(context, 40),
                right: scaleWidth(context, 40),
                top: scaleHeight(context, 30),
                bottom: scaleHeight(context, 30)),
            child: Row(children: [
              Container(
                  width: scaleWidth(context, 90),
                  height: scaleWidth(context, 90),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 133, 127, 0.44),
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(monthToStr,
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        SizedBox(height: 1),
                        Text(day.toString(),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700))
                      ])),
              SizedBox(width: scaleWidth(context, 30)),
              Container(
                  width: scaleWidth(context, 150),
                  child: Column(children: [
                    Text(title, style: TextStyle(fontSize: 25, height: 1.5)),
                    SizedBox(height: 10),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: SizedBox(
                            child: Row(children: [
                          Image.asset("assets/images/pencil.png"),
                          SizedBox(width: 10),
                          Text("write diary",
                              style: TextStyle(color: Colors.grey))
                        ])))
                  ]))
            ])),
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: scaleWidth(context, 40),
                    right: scaleWidth(context, 40),
                    top: scaleWidth(context, 10),
                  ),
                  child: Column(children: [
                    SizedBox(height: 20),
                    Container(
                        width: double.infinity,
                        child: Text("Playlist for recent mood",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500))),
                    Container(
                        width: double.infinity,
                        height: scaleHeight(context, 160),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              video != null
                                  ? Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Player(video, 280))
                                  : SizedBox(
                                      child: Column(
                                      children: [
                                        Text(
                                            "There is no recommended playlist.",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey)),
                                        SizedBox(height: 5),
                                        Text("Write a diary!",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey))
                                      ],
                                    ))
                            ])),
                  ])),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: scaleWidth(context, 40),
                  ),
                  child: Column(children: [
                    SizedBox(height: 20),
                    Container(
                        width: double.infinity,
                        child: Text("How to be a good parent",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500))),
                    Container(
                        width: double.infinity,
                        height: scaleHeight(context, 200),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: recommendList.map((recommend) {
                              return TipBox(recommend["title"],
                                  recommend["imgLink"], recommend["link"]);
                            }).toList())))
                  ])),
              IconButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  icon: Icon(Icons.ac_unit))
            ]),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "init"),
    );
  }
}

Container TipBox(String title, String imgLink, String link) {
  final Uri url = Uri.parse(link);

  return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            _launchUrl(url);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(color: Colors.red, width: 120),
                SizedBox(height: 10),
                Text(title)
              ])));
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
