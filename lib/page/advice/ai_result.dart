import "dart:math";

import "package:aeye/component/common/bottom_bar.dart";
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';

class AiResult extends StatefulWidget {
  const AiResult({Key? key, required this.title, required this.solutions})
      : super(key: key);

  final String title;
  final List solutions;

  @override
  State<AiResult> createState() => _AiResultState();
}

class _AiResultState extends State<AiResult> with TickerProviderStateMixin {
  List curData = [
    {
      "index": 1,
      "title": "Make vegetables fun and appealing",
      "content":
          "Cut vegetables into fun shapes, or serve them with a dip that Alex likes. You can also try cooking vegetables in different ways, such as roasting, grilling, or steaming."
    },
    {
      "index": 2,
      "title": "Be a role model",
      "content":
          "Alex is more likely to eat vegetables if they see you eating them. Make sure to include vegetables in your own meals and snacks."
    },
    {
      "index": 3,
      "title": "Don't force it",
      "content":
          "If Alex refuses to eat vegetables, don't force them. This will only make them more resistant. Instead, try offering them vegetables again at a later time."
    },
    {
      "index": 4,
      "title": "Make it a game",
      "content":
          "Turn eating vegetables into a game. You can try seeing who can eat the most vegetables in a minute, or who can make the funniest face while eating a vegetable."
    },
    {
      "index": 5,
      "title": "Offer positive reinforcement",
      "content":
          "Praise Alex when they do eat vegetables. You can also offer them a small reward, such as a sticker or a piece of fruit."
    },
  ];

  late final AnimationController _FirstController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _FirstAnimation = CurvedAnimation(
    parent: _FirstController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _SecondController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _SecondAnimation = CurvedAnimation(
    parent: _SecondController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _ThirdController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _ThirdAnimation = CurvedAnimation(
    parent: _ThirdController,
    curve: Curves.easeInOut,
  );
  late final AnimationController _FourthController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _FourthAnimation = CurvedAnimation(
    parent: _FourthController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _FifthController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _FifthAnimation = CurvedAnimation(
    parent: _FifthController,
    curve: Curves.easeInOut,
  );

  int? curOpen = null;
  setCurOpen(int? num) {
    setState(() {
      curOpen = num;
    });
  }

  late List controllerList = [
    _FirstController,
    _SecondController,
    _ThirdController,
    _FourthController,
    _FifthController
  ];

  late List<Animation> animationList = [
    _FirstAnimation,
    _SecondAnimation,
    _ThirdAnimation,
    _FourthAnimation,
    _FifthAnimation
  ];

  void adviceOpen(int curNum) {
    if (curOpen != null) {
      AnimationController prevController = controllerList[curOpen!];
      prevController.animateBack(0);
      print("is back");
    }
    if (curOpen == curNum) {
      setCurOpen(null);
      return;
    }
    setCurOpen(curNum);
    AnimationController curController = controllerList[curNum];
    curController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _FirstController.dispose();
    _SecondController.dispose();
    _ThirdController.dispose();
    _FourthController.dispose();
    _FifthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        titleSpacing: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              return;
            },
          );
        }),
        backgroundColor: Color(0xffFFF2CB),
        elevation: 0.1,
        centerTitle: false,
        title: Container(
          child: Row(
            children: [
              Text("Solution",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.solutions.map((data) {
                  int idx = curData.indexOf(data);
                  return AdviceBlock(
                      order: idx,
                      title: data["title"],
                      advice: data["content"],
                      value: animationList[idx].value,
                      state: curOpen == idx,
                      adviceOpen: adviceOpen);
                }).toList())),
      ),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "advice"),
    );
  }
}

class AdviceBlock extends StatefulWidget {
  const AdviceBlock(
      {Key? key,
      required this.order,
      required this.title,
      required this.advice,
      required this.value,
      required this.state,
      required this.adviceOpen})
      : super(key: key);

  final int order;
  final String title;
  final String advice;
  final double value;
  final bool state;
  final Function(int) adviceOpen;

  @override
  State<AdviceBlock> createState() => _AdviceBlockState();
}

class _AdviceBlockState extends State<AdviceBlock> {
  double _calculateExpandedHeight(String text, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 250, maxWidth: 250);
    return textPainter.height;
  }

  @override
  Widget build(BuildContext context) {
    double opacity = widget.value;

    double titleOpacity = ((widget.value - 0.5)).abs() + 0.5;

    double wrapperWidth = MediaQuery.of(context).size.width * 0.9;

    final minTextStyle =
        TextStyle(color: Colors.black, height: 1.9, fontSize: 18.0);
    final minHeight = _calculateExpandedHeight(widget.title, minTextStyle);

    final maxTextStyle = TextStyle(height: 1.5, fontSize: 16.0);
    final maxHeight = _calculateExpandedHeight(widget.advice, maxTextStyle);

    double curHeight = (20 + maxHeight) * min(1, widget.value * 2);

    double rotateAngle = 1 * pi * (1 / 2) + pi * (1 - widget.value);

    return GestureDetector(
      onTap: () {
        widget.adviceOpen(widget.order);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 0))
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          width: wrapperWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color(0xffFFF2CB).withOpacity(opacity),
          ),
          child: Container(
            width: wrapperWidth,
            padding: EdgeInsets.only(top: 10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Opacity(
                        opacity: titleOpacity,
                        child: Text((widget.order + 1).toString(),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffED5564))),
                      )),
                  SizedBox(width: 10),
                  Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: titleOpacity,
                              child: Text(widget.title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      height: 1.9,
                                      color: widget.value > 0.5
                                          ? Color(0xffED5564)
                                          : Colors.black)),
                            ),
                            widget.value < 0.5
                                ? SizedBox(height: 0)
                                : Container(
                                    child: Column(children: [
                                    SizedBox(height: 10),
                                    Opacity(
                                      opacity: opacity,
                                      child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                              text: widget.advice,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  height: 1.5,
                                                  fontSize: 16.0))),
                                    ),
                                  ])),
                            // widget.value < 0.5
                            //     ? SizedBox(height: 0)
                            //     : SizedBox(height: 10),
                            // widget.value < 0.5
                            //     ? SizedBox(height: 0)
                            //     : Opacity(
                            //         opacity: opacity,
                            //         child: RichText(
                            //             overflow: TextOverflow.clip,
                            //             text: TextSpan(
                            //                 text: widget.advice,
                            //                 style: TextStyle(
                            //                     color: Colors.black,
                            //                     height: 1.5,
                            //                     fontSize: 16.0))),
                            //       ),
                            // widget.value < 0.5
                            //     ? SizedBox(height: 0)
                            //     : SizedBox(height: 20)
                          ])),
                  SizedBox(width: 20),
                  Transform.rotate(
                      angle: rotateAngle,
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios, color: Color(0xffD5D5D5)),
                        ],
                      )))
                ]),
          ),
        ),
      ),
    );
  }
}

class _AdviceData {
  _AdviceData(this.title, this.advice);
  final String title;
  final String advice;
}
