import 'package:aeye/page/emotion/emoticon_month_result.dart';
import "package:aeye/services/emotion.dart";
import "package:flutter/material.dart";

EmotionServices emotionService = new EmotionServices();

//void Function(bool state) setIsLoading

AppBar Header(DateTime? curDate, String curPath) {
  String title = "";
  switch (curPath) {
    case ("init"):
      title = "A-eye";
      break;
    case ("emotionDiary"):
      title = "Diary";
      break;
    case ("babyMonitor"):
      title = "Baby Monitor";
      break;
    case ("advice"):
      title = "Advice";
      break;
    default:
      break;
  }
  ;

  if (curPath == "init") {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFF7DF),
        elevation: 0,
        centerTitle: false,
        title: SizedBox(
          child: Row(
            children: const [
              SizedBox(width: 10),
              Text("A-eye",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
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

  if (curPath == "advice") {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFF7DF),
        elevation: 0.1,
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
        Map response = await emotionService.getMonthlyResult(
            widget.curDate.year, widget.curDate.month);
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
