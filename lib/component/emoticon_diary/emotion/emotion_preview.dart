import "package:flutter/material.dart";

import "../../../asset/imoticon_url.dart";
import "../../../page/emotion_result.dart";

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
  const EmotionPreview(
      {Key? key,
      required this.curDates,
      required this.dateSelected,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.setNavBarUp})
      : super(key: key);

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
        datesInfo: widget.curDates,
        date: widget.dateSelected,
        setInputEmotionUp: widget.setInputEmotionUp,
        setEmotionSelectorUp: widget.setEmotionSelectorUp,
        setNavBarUp: widget.setNavBarUp);
  }
}

class EmotionPreviewBox extends StatefulWidget {
  const EmotionPreviewBox(
      {Key? key,
      required this.datesInfo,
      required this.date,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.setNavBarUp})
      : super(key: key);

  final Map datesInfo;
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

    Map dateInfo = widget.datesInfo[day];

    String? id = dateInfo["id"];
    String? emotion = dateInfo["emotion"];
    String content =
        id == null ? "Write in today's diary" : dateInfo["content"];

    String monthToEng = Month[month];

    String selectDay = '${monthToEng} ${day} ${year}';

    String imageLink = ImageLink[emotion];

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
            date: widget.date,
            emotion: emotion,
            image: imageLink,
            title: selectDay,
            setInputEmotionUp: widget.setInputEmotionUp,
            setEmotionSelectorUp: widget.setEmotionSelectorUp,
            setNavBarUp: widget.setNavBarUp),
        SizedBox(height: 20),
        PreviewBoxBody(content)
      ]),
    );
  }
}

class PreviewBoxHeader extends StatefulWidget {
  const PreviewBoxHeader(
      {Key? key,
      required this.date,
      required this.emotion,
      required this.image,
      required this.title,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.setNavBarUp})
      : super(key: key);
  final DateTime date;
  final String? emotion;
  final String image;
  final String title;
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
                  Image.asset(height: 50, widget.image),
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
                date: widget.date,
                emotion: widget.emotion,
                setInputEmotionUp: widget.setInputEmotionUp,
                setEmotionSelectorUp: widget.setEmotionSelectorUp,
                setNavBarUp: widget.setNavBarUp)
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
      required this.date,
      required this.emotion,
      required this.setInputEmotionUp,
      required this.setEmotionSelectorUp,
      required this.setNavBarUp})
      : super(key: key);
  final DateTime date;
  final String? emotion;
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
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        if (item == SampleItem.itemOne) {
          widget.setInputEmotionUp(true);
        } else if (item == SampleItem.itemTwo) {
          widget.setInputEmotionUp(true);
          widget.setEmotionSelectorUp(true);
          widget.setNavBarUp(false);
        } else {
          widget.setInputEmotionUp(false);
          widget.setEmotionSelectorUp(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmotionResult(
                      date: widget.date,
                      emotion: widget.emotion,
                      emotionText: "You had a wonderful day!",
                      sentimentLevel: 4.12,
                      recommend: "hi")));
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
