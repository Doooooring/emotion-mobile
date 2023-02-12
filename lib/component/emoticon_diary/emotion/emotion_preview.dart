import "package:flutter/material.dart";

import "../../../page/emotion_result.dart";
import "../../../services/emotion.dart";

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
    required this.curDates,
    required this.dateSelected,
    required this.setInputEmotionUp,
    required this.setEmotionSelectorUp,
    required this.setNavBarUp,
  }) : super(key: key);

  final Map curDates;
  final DateTime dateSelected;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setNavBarUp;

  @override
  State<EmotionPreview> createState() => _EmotionPreviewState();
}

class _EmotionPreviewState extends State<EmotionPreview> {
  @override
  Widget build(BuildContext context) {
    return EmotionPreviewBox(
      curDates: widget.curDates,
      date: widget.dateSelected,
      setInputEmotionUp: widget.setInputEmotionUp,
      setEmotionSelectorUp: widget.setEmotionSelectorUp,
      setNavBarUp: widget.setNavBarUp,
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
    required this.setNavBarUp,
  }) : super(key: key);

  final Map curDates;
  final DateTime date;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setNavBarUp;
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

    Color backgroundColor =
        id == null ? Color.fromRGBO(250, 250, 250, 0.2) : Color(0xffFFF6DA);

    return Container(
      width: 400,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: Offset(0, 0))
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
          setNavBarUp: widget.setNavBarUp,
        ),
        SizedBox(height: 20),
        PreviewBoxBody(content)
      ]),
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
    required this.setNavBarUp,
  }) : super(key: key);
  final int? id;
  final DateTime date;
  final String emotion;
  final String title;
  final Map curDates;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setNavBarUp;

  @override
  State<PreviewBoxHeader> createState() => _PreviewBoxHeaderState();
}

class _PreviewBoxHeaderState extends State<PreviewBoxHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      child: Row(children: [
        Container(
            width: 300,
            height: 60,
            padding: EdgeInsets.only(left: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(height: 50, widget.emotion),
                  SizedBox(
                    width: 30,
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
          width: 80,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            PopUpMenuButtonWrapper(
              id: widget.id,
              date: widget.date,
              emotion: widget.emotion,
              curDates: widget.curDates,
              setInputEmotionUp: widget.setInputEmotionUp,
              setEmotionSelectorUp: widget.setEmotionSelectorUp,
              setNavBarUp: widget.setNavBarUp,
            )
          ]),
        )
      ]),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class PopUpMenuButtonWrapper extends StatefulWidget {
  const PopUpMenuButtonWrapper(
      {Key? key,
      required this.id,
      required this.date,
      required this.emotion,
      required this.curDates,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.setNavBarUp})
      : super(key: key);
  final int? id;
  final DateTime date;
  final String? emotion;
  final Map curDates;
  final void Function(bool) setInputEmotionUp;
  final void Function(bool) setEmotionSelectorUp;
  final void Function(bool) setNavBarUp;

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
        // Callback that sets the selected popup menu item.
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
        // Callback that sets the selected popup menu item.
        onSelected: (SampleItem item) async {
          if (item == SampleItem.itemOne) {
            widget.setInputEmotionUp(true);
          } else {
            Map response =
                await emotionService.getResultPage(widget.id, widget.date);
            if (!mounted) {
              return;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmotionResult(
                        date: response["date"],
                        emotion: response["emotion"],
                        emotionText: response["emotionText"],
                        sentimentLevel: response["sentimentalLevel"],
                        recommend: response["recommend"])));
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

Container PreviewBoxBody(String text) {
  return Container(
      width: 360,
      child: Text(
        style: TextStyle(
            fontSize: 18,
            height: 1.4,
            color: Colors.black,
            fontWeight: FontWeight.w500),
        text,
      ));
}
