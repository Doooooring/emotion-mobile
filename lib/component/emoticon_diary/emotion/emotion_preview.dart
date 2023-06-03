import "package:aeye/controller/sizeController.dart";
import "package:aeye/controller/userController.dart";
import 'package:aeye/page/emotion/emotion_comment.dart';
import 'package:aeye/page/emotion/emotion_result.dart';
import "package:aeye/services/emotion.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

EmotionServices emotionService = new EmotionServices();

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

class EmotionPreview extends StatefulWidget {
  const EmotionPreview({
    Key? key,
    required this.isLoading,
    required this.curDates,
    required this.dateSelected,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final bool isLoading;
  final Map curDates;
  final DateTime dateSelected;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  @override
  State<EmotionPreview> createState() => _EmotionPreviewState();
}

class _EmotionPreviewState extends State<EmotionPreview> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? SizedBox(width: 0, height: 0)
        : EmotionPreviewBox(
            curDates: widget.curDates,
            date: widget.dateSelected,
            setInputEmotionUp: widget.setInputEmotionUp,
            setEmotionSelectorUp: widget.setEmotionSelectorUp,
          );
  }
}

class EmotionPreviewBox extends StatefulWidget {
  const EmotionPreviewBox({
    Key? key,
    required this.curDates,
    required this.date,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);

  final Map curDates;
  final DateTime date;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  @override
  State<EmotionPreviewBox> createState() => _EmotionPreviewBoxState();
}

class _EmotionPreviewBoxState extends State<EmotionPreviewBox> {
  @override
  Widget build(BuildContext context) {
    String day = widget.date.day.toString();
    String month = widget.date.month.toString();
    String year = widget.date.year.toString();

    Map dateInfo = widget.curDates[day];

    int? id = dateInfo["id"];
    String emotion = dateInfo["emotion"] == null
        ? "assets/images/mean.png"
        : 'assets/images/${dateInfo["emotion"]}.png';
    String content = dateInfo["content"] ?? "Write in today's diary";

    String monthToEng = Month[month];

    String selectDay = '${monthToEng} ${day} ${year}';

    Color fontColor =
        id == null ? Color.fromRGBO(130, 130, 130, 1) : Colors.black;

    Color backgroundColor = id == null ? Color(0xffFCFCFC) : Color(0xffFFF6DA);

    return GestureDetector(
      onTap: () {
        print("emotion up");
        widget.setInputEmotionUp(true);
        print("here");
      },
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 30),
        width: 380,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 18.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 6))
            ],
            color: backgroundColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          PreviewBoxHeader(
            id: id,
            date: widget.date,
            emotion: emotion,
            title: selectDay,
            curDates: widget.curDates,
            setInputEmotionUp: widget.setInputEmotionUp,
            setEmotionSelectorUp: widget.setEmotionSelectorUp,
          ),
          SizedBox(height: 20),
          PreviewBoxBody(context, content, fontColor),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                id == null
                    ? SizedBox(width: 0)
                    : ButtonToComment(context, id, widget.date.year,
                        widget.date.month, widget.date.day),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class PreviewBoxHeader extends StatefulWidget {
  const PreviewBoxHeader({
    Key? key,
    required this.id,
    required this.date,
    required this.emotion,
    required this.title,
    required this.curDates,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final int? id;
  final DateTime date;
  final String emotion;
  final String title;
  final Map curDates;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  @override
  State<PreviewBoxHeader> createState() => _PreviewBoxHeaderState();
}

class _PreviewBoxHeaderState extends State<PreviewBoxHeader> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    String role = userController.role.toString();

    return Container(
      width: double.infinity,
      child: Row(children: [
        Container(
            width: scaleWidth(context, 250),
            height: 60,
            padding: EdgeInsets.only(left: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(width: 50, height: 50, widget.emotion),
                  SizedBox(
                    width: scaleWidth(context, 30),
                  ),
                  Container(
                      child: Text(
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          widget.title))
                ])),
        Container(
          width: 60,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            role == "main"
                ? PopUpMenuButtonWrapper(
                    id: widget.id,
                    date: widget.date,
                    emotion: widget.emotion,
                    curDates: widget.curDates,
                    setInputEmotionUp: widget.setInputEmotionUp,
                    setEmotionSelectorUp: widget.setEmotionSelectorUp,
                  )
                : PopUpForSub(id: widget.id, date: widget.date)
          ]),
        )
      ]),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class PopUpMenuButtonWrapper extends StatefulWidget {
  const PopUpMenuButtonWrapper({
    Key? key,
    required this.id,
    required this.date,
    required this.emotion,
    required this.curDates,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
  }) : super(key: key);
  final int? id;
  final DateTime date;
  final String? emotion;
  final Map curDates;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;

  @override
  State<PopUpMenuButtonWrapper> createState() => _PopUpMenuButtonWrapperState();
}

class _PopUpMenuButtonWrapperState extends State<PopUpMenuButtonWrapper> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    if (widget.id == null) {
      return PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        onSelected: (SampleItem item) {
          if (item == SampleItem.itemOne) {
            widget.setInputEmotionUp(true);
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: SampleItem.itemOne,
            child: Text("edit"),
          ),
        ],
      );
    } else {
      return PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        onSelected: (SampleItem item) async {
          if (item == SampleItem.itemOne) {
            widget.setInputEmotionUp(true);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DailyReportWrapper(id: widget.id!, date: widget.date)));
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: SampleItem.itemOne,
            child: Text("edit"),
          ),
          PopupMenuItem(
            value: SampleItem.itemTwo,
            child: Text("daily report"),
          ),
        ],
      );
    }
  }
}

class PopUpForSub extends StatefulWidget {
  const PopUpForSub({
    Key? key,
    required this.id,
    required this.date,
  }) : super(key: key);

  final int? id;
  final DateTime date;

  @override
  State<PopUpForSub> createState() => _PopUpForSubState();
}

class _PopUpForSubState extends State<PopUpForSub> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? SizedBox(height: 0)
        : PopupMenuButton<SampleItem>(
            initialValue: selectedMenu,
            onSelected: (SampleItem item) async {
              Map response =
                  await emotionService.getResultPage(widget.id, widget.date);
              if (!mounted) {
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DailReport(
                          date: response["date"],
                          emotion: response["emotion"],
                          emotionText: response["emotionText"],
                          sentimentLevel: response["sentimentLevel"],
                          videoUrl: response["videoUrl"],
                          title: response["title"])));
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: SampleItem.itemTwo,
                child: Text("daily report"),
              ),
            ],
          );
  }
}

Container PreviewBoxBody(BuildContext context, String text, Color color) {
  return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          left: scaleWidth(context, 20), right: scaleWidth(context, 20)),
      child: Text(
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: color),
        text,
      ));
}

TextButton ButtonToComment(
    BuildContext context, int id, int year, int month, int day) {
  return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmotionComment(
                    id: id, year: year, month: month, day: day)));
      },
      child: Text("View comments", style: TextStyle(color: Colors.grey)));
}
