import 'package:firstproject/controller/routeController.dart';
import 'package:firstproject/page/baby_monitor.dart';
import 'package:firstproject/page/emotion_diary.dart';
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
    return widget.state
        ? BottomAppBar(
            clipBehavior: Clip.antiAlias,
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            notchMargin: 15,
            child: SizedBox(
              width: double.infinity,
              height: 81,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color.fromRGBO(50, 50, 50, 0.1),
                          Color.fromRGBO(50, 50, 50, 0.3)
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 1,
                      ),
                      BottomAppBar(
                        clipBehavior: Clip.antiAlias,
                        shape: const CircularNotchedRectangle(),
                        color: Colors.white,
                        elevation: 0,
                        notchMargin: 15,
                        child: SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            if (routeController.curPath
                                                    .toString() ==
                                                "babyMonitor") {
                                              return;
                                            }
                                            routeController.toBabyMonitor();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BabyMonitor()));
                                          },
                                          icon: Image.asset(
                                            color: routeController.curPath
                                                        .toString() ==
                                                    "babyMonitor"
                                                ? Colors.black
                                                : Colors.grey,
                                            width: 45,
                                            "assets/images/babyFace@2.png",
                                          )),
                                      Text("Baby Monitor",
                                          style: TextStyle(
                                            color: routeController.curPath
                                                        .toString() ==
                                                    "babyMonitor"
                                                ? Colors.black
                                                : Colors.grey,
                                          ))
                                    ],
                                  ),
                                  SizedBox(width: 80),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            if (routeController.curPath ==
                                                "emotionDiary") {
                                              return;
                                            }
                                            routeController.toEmotionDiary();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CalendarWrapper()));
                                          },
                                          icon: Image.asset(
                                              color: routeController.curPath ==
                                                      "emotionDiary"
                                                  ? Colors.black
                                                  : Colors.grey,
                                              width: 50,
                                              "assets/images/diary.png")),
                                      Text("Diary",
                                          style: TextStyle(
                                            color: routeController.curPath ==
                                                    "emotionDiary"
                                                ? Colors.black
                                                : Colors.grey,
                                          ))
                                    ],
                                  )
                                ])),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox(height: 0);
  }
}
