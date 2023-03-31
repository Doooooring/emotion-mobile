import "package:aeye/page/advice/adviceRouter.dart";
import 'package:aeye/page/babyMonitor/babyMonitor.dart';
import 'package:aeye/page/emotion/emotion_diary.dart';
import "package:aeye/page/initial.dart";
import 'package:flutter/material.dart';
import "package:get/get.dart";

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.state, required this.curPath})
      : super(key: key);
  final bool state;
  final String curPath;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    List<String> linkList = ["init", "babyMonitor", "emotionDiary", "advice"];
    return widget.state
        ? BottomAppBar(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: linkList.map((link) {
                  return NavComp(context, link, widget.curPath);
                }).toList()))
        : SizedBox(height: 0);
  }
}

OutlinedButton NavComp(BuildContext context, String link, String curPath) {
  String title = "";
  String imageLink = "";
  Widget? addContext;
  switch (link) {
    case "init":
      title = "Home";
      imageLink = "assets/images/home.png";
      addContext = InitialPage();
      break;
    case "babyMonitor":
      title = "BabyMonitor";
      imageLink = "assets/images/babyface.png";
      //addContext = BabyMonitor();
      addContext = Monitor();
      break;
    case "emotionDiary":
      title = "Diary";
      imageLink = "assets/images/diary.png";
      addContext = CalendarWrapper();
      break;
    case "advice":
      title = "Advice";
      imageLink = "assets/images/search.png";
      addContext = AdviceRouter();
      break;
    default:
      break;
  }

  if (title == "Home") {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
        onPressed: () {
          if (curPath == link) {
            return;
          }
          Get.offAll(InitialPage());
        },
        child: Opacity(
          opacity: curPath == link ? 1 : 0.5,
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

  return title == "BabyMonitor"
      ? OutlinedButton(
          style:
              OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          onPressed: () {
            if (curPath == link) {
              return;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => addContext ?? Container()));
          },
          child: Opacity(
            opacity: curPath == link ? 1 : 0.5,
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
            if (curPath == link) {
              return;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => addContext ?? Container()));
          },
          child: Opacity(
            opacity: curPath == link ? 1 : 0.5,
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
