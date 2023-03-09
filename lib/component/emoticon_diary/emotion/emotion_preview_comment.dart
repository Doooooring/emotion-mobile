import "package:flutter/material.dart";

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
      required this.year,
      required this.month,
      required this.day,
      required this.emotion,
      required this.diary})
      : super(key: key);

  final int year;
  final int month;
  final int day;
  final String emotion;
  final String diary;

  @override
  State<EmotionPreview> createState() => _EmotionPreviewState();
}

class _EmotionPreviewState extends State<EmotionPreview> {
  @override
  Widget build(BuildContext context) {
    return EmotionPreviewBox(
        year: widget.year,
        month: widget.month,
        day: widget.day,
        emotion: widget.emotion,
        diary: widget.diary);
  }
}

class EmotionPreviewBox extends StatefulWidget {
  const EmotionPreviewBox(
      {Key? key,
      required this.year,
      required this.month,
      required this.day,
      required this.emotion,
      required this.diary})
      : super(key: key);

  final int year;
  final int month;
  final int day;
  final String emotion;
  final String diary;

  @override
  State<EmotionPreviewBox> createState() => _EmotionPreviewBoxState();
}

class _EmotionPreviewBoxState extends State<EmotionPreviewBox> {
  @override
  Widget build(BuildContext context) {
    String day = widget.day.toString();
    String month = widget.month.toString();
    String year = widget.year.toString();

    String emotion = 'assets/images/${widget.emotion}.png';

    String monthToEng = Month[month];

    String headerTitle = '${monthToEng} ${day} ${year}';

    Color backgroundColor = Color(0xffFFF6DA);

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
      width: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 18.0,
                spreadRadius: 0.0,
                offset: Offset(0, 6))
          ],
          color: backgroundColor),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        PreviewBoxHeader(
          emotion: emotion,
          title: headerTitle,
        ),
        SizedBox(height: 20),
        PreviewBoxBody(widget.diary)
      ]),
    );
  }
}

class PreviewBoxHeader extends StatefulWidget {
  const PreviewBoxHeader({
    Key? key,
    required this.emotion,
    required this.title,
  }) : super(key: key);

  final String emotion;
  final String title;

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
      ]),
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
