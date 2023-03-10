import "dart:developer";

import 'package:firstproject/controller/routeController.dart';
import "package:firstproject/page/baby_monitor.dart";
import "package:firstproject/page/emotion_diary.dart";
import "package:firstproject/page/initial.dart";
import 'package:flutter/material.dart';
import "package:get/get.dart";

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.state}) : super(key: key);
  final bool state;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();
    List<String> linkList = ["init", "babyMonitor", "emotionDiary", "advice"];

    return widget.state
        ? BottomAppBar(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: linkList.map((link) {
                  return NavComp(context, link, routeController);
                }).toList()))
        : SizedBox(height: 0);
  }
}

OutlinedButton NavComp(
    BuildContext context, String link, RouteController routeController) {
  String title = "";
  String imageLink = "";
  Widget? addContext;
  Function curMethod;
  switch (link) {
    case "init":
      title = "Home";
      imageLink = "assets/images/home.png";
      addContext = InitialPage();
      curMethod = routeController.toInit;
      break;
    case "babyMonitor":
      title = "BabyMonitor";
      imageLink = "assets/images/babyface.png";
      addContext = BabyMonitor();
      curMethod = routeController.toBabyMonitor;
      break;
    case "emotionDiary":
      title = "Diary";
      imageLink = "assets/images/diary.png";
      addContext = CalendarWrapper();
      curMethod = routeController.toEmotionDiary;
      break;
    case "advice":
      title = "Advice";
      imageLink = "assets/images/search.png";
      addContext = CalendarWrapper();
      curMethod = routeController.toAdvice;
      break;
    default:
      curMethod = () {
        return;
      };
  }

  return title == "BabyMonitor"
      ? OutlinedButton(
          style:
              OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          onPressed: () {
            if (routeController.curPath.toString() == link) {
              log("here");
              return;
            }
            curMethod();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => addContext ?? Container()));
          },
          child: Opacity(
            opacity: routeController.curPath.toString() == link ? 1 : 0.5,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 100,
              child: Column(children: [
                Image.asset(width: 30, height: 30, imageLink),
                SizedBox(height: 5),
                Text("Baby", style: TextStyle(color: Colors.black)),
                Text("Monitor", style: TextStyle(color: Colors.black))
              ]),
            ),
          ))
      : OutlinedButton(
          style:
              OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          onPressed: () {
            if (routeController.curPath.toString() == link) {
              return;
            }
            curMethod();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => addContext ?? Container()));
          },
          child: Opacity(
            opacity: routeController.curPath.toString() == link ? 1 : 0.5,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(),
              height: 100,
              child: Column(children: [
                Image.asset(width: 30, height: 30, imageLink),
                SizedBox(height: 5),
                Text(title, style: TextStyle(color: Colors.black))
              ]),
            ),
          ));
}
