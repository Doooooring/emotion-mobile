import "dart:developer";

import "package:firstproject/controller/routeController.dart";
import "package:firstproject/page/emoticon_month_result.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

AppBar Header() {
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
            children: [
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
            icon: Icon(Icons.keyboard_control, color: Colors.black),
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
            if (curPath != "init") {
              routeController.toInit();
              Navigator.pop(context);
              return;
            } else {
              return;
            }
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
        curPath == "emotionDiary" ? MonthResultButton() : SizedBox(width: 0),
        PopupMenuButton(
          icon: Icon(Icons.keyboard_control, color: Colors.black),
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
  const MonthResultButton({Key? key}) : super(key: key);

  @override
  State<MonthResultButton> createState() => _MonthResultButtonState();
}

class _MonthResultButtonState extends State<MonthResultButton> {
  @override
  Widget build(BuildContext context) {
    log("here");
    return IconButton(
      icon: Image.asset("assets/images/heartemoticon.png"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmoticonMonthResult()));
      },
    );
  }
}
