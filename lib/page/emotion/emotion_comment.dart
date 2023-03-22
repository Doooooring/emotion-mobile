import "dart:ui";

import "package:aeye/component/emoticon_diary/emotion/emotion_preview_comment.dart";
import "package:aeye/controller/sizeController.dart";
import "package:aeye/services/emotion.dart";
import "package:aeye/utils/interface/comment.dart";
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

// {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
// {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
// {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
// {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"},
// {"date": "Feb 18 2023", "type": "main", "comment": "You are so sweet"}

EmotionServices emotionServices = EmotionServices();

class EmotionComment extends StatefulWidget {
  const EmotionComment({
    Key? key,
    required this.id,
    required this.year,
    required this.month,
    required this.day,
  }) : super(key: key);

  final int id;
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
  List<Comment> curComment = [];
  void setCurComment(Comment comment) {
    setState(() {
      curComment.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    Map dataJson = {
      "emotion": "content-3",
      "content": "Liam took care of Mark instead of me. I had a day off XD.",
      "comment": [
        {
          "date": "Mar 17 2023",
          "type": "sub",
          "comment": "No problem honey! I am glad you got rest."
        }
      ]
    };

    CommentPageData? curData = null;
    setCurData(CommentPageData commentPageData) {
      setState(() {
        curData = commentPageData;
      });
    }

    addComment(Comment comment) {
      setState(() {
        curData!.comment.add(comment);
      });
    }
    // if (curComment.length == 0) {
    //   setCurComment(curData.comment[0]);
    // }

    void removeFocus(BuildContext context) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }

    _asyncMethod() async {
      CommentPageData commentPageData =
          await emotionServices.getComments(widget.id.toString());
      setCurData(commentPageData);
    }

    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _asyncMethod();
      });
    }

    return curData == null
        ? Scaffold()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: Header(widget.month, widget.day),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                removeFocus(context);
              },
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Stack(children: [
                    Container(
                      child: SingleChildScrollView(
                        child: Container(
                            child: Column(children: [
                          EmotionPreview(
                              year: widget.year,
                              month: widget.month,
                              day: widget.day,
                              emotion: curData!.emotion,
                              diary: curData!.diary),
                          Column(
                            children: curComment.map((Comment data) {
                              return CommentLabel(context, data);
                            }).toList(),
                          ),
                        ])),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.bottomCenter,
                        child: CommentInput(widget.id, controller,
                            setCurComment, curComment, context, removeFocus))
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

Container CommentLabel(BuildContext context, Comment comment) {
  String date = comment.date;
  String type = comment.type;
  String body = comment.comment;

  if (type == "main") {
    Color backgroundColor = Color(0xffFFF6DA);
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CommentBox(context, backgroundColor, date, body),
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
          CommentBox(context, backgroundColor, date, body)
        ]));
  }
}

Container CommentBox(
    BuildContext context, Color backgroundColor, String date, String body) {
  return Container(
      width: scaleWidth(context, 270),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 10),
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
        SizedBox(height: 5),
        Text(body,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ))
      ]));
}

Row CommentInput(
    int id,
    TextEditingController controller,
    void Function(Comment) setCurComment,
    List<Comment> curComment,
    BuildContext context,
    void Function(BuildContext) removeFocus) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 320,
          height: 70,
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
                controller: controller,
                scrollPadding: EdgeInsets.all(0),
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Add A Comment",
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.white))),
              ),
            ],
          )),
      IconButton(
          onPressed: () async {
            bool response = await emotionServices.postComments(
                id.toString(), controller.text);
            if (response) {
            } else {}
          },
          icon: Icon(Icons.send))
    ],
  );
}
