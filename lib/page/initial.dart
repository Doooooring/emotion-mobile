import 'dart:convert';

import 'package:aeye/controller/loginController.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';

import "../asset/url.dart";
import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../component/common/youtube_player.dart";
import "../controller/sizeController.dart";
import "../controller/userController.dart";
import "../page/emotion/emotion_diary.dart";
import "../page/login/chooseRole.dart";

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
        "https://justchillbabysleep.co.uk/2021/04/20/what-is-independent-sleep-a-guide-to-self-settling/",
    "imgLink": "assets/images/recommend2.png"
  },
  {
    "title": "Positive Parenting Tips",
    "link":
        "https://www.cdc.gov/ncbddd/childdevelopment/positiveparenting/index.html",
    "imgLink": "assets/images/recommend3.png"
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

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  UserController userController = UserController();
  LoginController loginController = Get.find();

  String? video = null;

  _asyncMethod() async {
    Map tokens = await loginController.getTokens();
    Uri endPoint = Uri.parse('$HOST_URL/home');

    http.Response response = await http.get(endPoint, headers: {
      "Content-Type": "application/json",
      "Authorization": tokens["access"],
      "cookie": tokens["refresh"]
    });
    Map? result = json.decode(utf8.decode(response.bodyBytes))["result"];

    if (result == null) {
      Get.back();
      Get.to(() => ChooseRole());
      return;
    }

    String loginCode = result["code"];
    String role = result["role"];
    Map? recommendVideo = result["video"];
    userController.role = role.obs;

    if (role == "main") {
      userController.getCode(loginCode);
    }

    if (recommendVideo != null) {
      video = recommendVideo["videoUrl"];
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int month = today.month;
    int day = today.day;

    String monthToStr = Month[month.toString()];
    String title = "How are you today?";

    return Scaffold(
      appBar: Header(null, "init"),
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
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
                        color: Color.fromRGBO(255, 113, 127, 0.41),
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
                      Text(title,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              height: 1.3)),
                      SizedBox(height: 10),
                      video != null
                          ? SizedBox(width: 0)
                          : TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Get.to(CalendarWrapper());
                              },
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
                                  fontSize: 25, fontWeight: FontWeight.w500))),
                      Container(
                          width: double.infinity,
                          height: scaleHeight(context, 200),
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
                                        child: Player(video!, 330))
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
                    child: Column(children: [
                      SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.only(left: scaleWidth(context, 40)),
                          child: Text("How to be a good parent",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500))),
                      SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                SizedBox(width: 40),
                                ...recommendList.map((recommend) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 20),
                                    child: TipBox(
                                        recommend["title"],
                                        recommend["imgLink"],
                                        recommend["link"]),
                                  );
                                }).toList()
                              ])))
                    ])),
                SizedBox(height: 30)
              ]),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "init"),
    );
  }
}

Container TipBox(String title, String imgLink, String link) {
  final Uri url = Uri.parse(link);

  return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(237, 237, 237, 0.44),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            _launchUrl(url);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 250,
                      height: 200,
                      child: Image.asset(width: 250, imgLink)),
                  Text(title, style: TextStyle(color: Colors.black))
                ]),
          )));
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
