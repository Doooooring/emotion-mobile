import "dart:ui";

import "package:firstproject/component/emoticon_diary/emotion/emotion_preview_comment.dart";
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

class EmotionComment extends StatefulWidget {
  const EmotionComment({
    Key? key,
    required this.year,
    required this.month,
    required this.day,
  }) : super(key: key);

  final int year;
  final int month;
  final int day;

  @override
  State<EmotionComment> createState() => _EmotionCommentState();
}

/**
 * current page data
 * {
 *  emotion : string,
 *  diary : string,
 *  comment : Array<Map>
 * }
 */

class _EmotionCommentState extends State<EmotionComment> {
  @override
  Widget build(BuildContext context) {
    Map dataJson = {
      "emotion": "excited-2",
      "diary": "Liam took care of Mark instead of me. I had a day off XD",
      "comment": [
        {
          "date": "Feb 18 2023",
          "type": "sub",
          "comment": "Liam took care of Mark instead of me. I had a day off XD"
        },
        {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
        {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
        {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
        {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
        {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"}
      ]
    };

    _CommentPageData curData = _CommentPageData.fromJson(dataJson);

    return Scaffold(
      appBar: Header(widget.month, widget.day),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(children: [
              Container(
                height: 680,
                child: SingleChildScrollView(
                  child: Container(
                      child: Column(children: [
                    EmotionPreview(
                        year: widget.year,
                        month: widget.month,
                        day: widget.day,
                        emotion: curData.emotion,
                        diary: curData.diary),
                    Column(
                      children: curData.comment.map((_Comment data) {
                        return CommentLabel(data);
                      }).toList(),
                    ),
                  ])),
                ),
              ),
              CommentInput()
            ])),
      ),
    );
  }
}

AppBar Header(int month, int day) {
  String monthToStr = Month[month.toString()];

  return AppBar(
    leading: Builder(builder: (BuildContext context) {
      return IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          });
    }),
    backgroundColor: Color(0xffFFF7DF),
    elevation: 0.0,
    centerTitle: false,
    title: SizedBox(
      child: Row(
        children: [
          Text("${monthToStr} ${day}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
        ],
      ),
    ),
  );
}

Container CommentLabel(_Comment comment) {
  String date = comment.date;
  String type = comment.type;
  String body = comment.comment;

  if (type == "main") {
    Color backgroundColor = Color(0xffFFF6DA);
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CommentBox(backgroundColor, date, body),
          Container(
              padding: EdgeInsets.only(top: 10),
              width: 50,
              child: Image.asset(
                  width: 23, height: 23, "assets/images/reply_right.png")),
        ]));
  } else {
    Color backgroundColor = Color(0xffFFE4DA);
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(top: 10),
              width: 50,
              child: Image.asset(
                  width: 23, height: 23, "assets/images/reply_left.png")),
          CommentBox(backgroundColor, date, body)
        ]));
  }
}

Container CommentBox(Color backgroundColor, String date, String body) {
  return Container(
      width: 340,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0, 6))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(date,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            )),
        SizedBox(height: 10),
        Text(body,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ))
      ]));
}

Container CommentInput() {
  return Container(
      height: 65,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(1),
                blurRadius: 1,
                spreadRadius: 0,
                offset: Offset(0, 0))
          ],
          borderRadius: BorderRadius.circular(45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            scrollPadding: EdgeInsets.all(0),
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(50, 50, 50, 0.4)),
            decoration: InputDecoration(
                hintText: "Add A Comment",
                labelStyle: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white))),
          ),
        ],
      ));
}

// data type
class _CommentPageData {
  _CommentPageData(this.emotion, this.diary, this.comment);

  final String emotion;
  final String diary;
  final List<_Comment> comment;

  factory _CommentPageData.fromJson(Map data) {
    String emotion = data["emotion"];
    String diary = data["diary"];

    List<_Comment> comments = data["comment"].map<_Comment>((Map comment) {
      return _Comment.fromJson(comment);
    }).toList();

    return _CommentPageData(emotion, diary, comments);
  }
}

class _Comment {
  _Comment(this.date, this.type, this.comment);

  final String date;
  final String type;
  final String comment;

  factory _Comment.fromJson(Map data) {
    String date = data["date"];
    String type = data["type"];
    String comment = data["comment"];

    return _Comment(date, type, comment);
  }
}
