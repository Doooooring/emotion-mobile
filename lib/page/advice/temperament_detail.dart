import "dart:math";

import "package:aeye/component/common/button_back.dart";
import "package:aeye/controller/sizeController.dart";
import "package:aeye/page/advice/add_info.dart";
import "package:aeye/page/advice/temperament_explain.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TemperamentDetail extends StatelessWidget {
  const TemperamentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: true
            ? SlideWrapper()
            : Container(
                color: Color(0xffFFF7DF),
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(
                    left: scaleWidth(context, 35),
                    right: scaleWidth(context, 35),
                    top: scaleHeight(context, 80)),
                child: Column(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonBack(),
                            Expanded(
                                child: Column(children: [
                              Text("What is",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400)),
                              Text("temperament?",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400))
                            ])),
                            Opacity(opacity: 0, child: ButtonBack())
                          ])),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(
                          left: scaleWidth(context, 20),
                          right: scaleWidth(context, 20),
                          top: scaleHeight(context, 20),
                          bottom: scaleHeight(context, 20)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Temperament",
                                style: TextStyle(
                                    fontSize: 22, color: Color(0xffFF717F))),
                            SizedBox(height: 10),
                            Text(
                                "is a person's own unique characteristic that he or she has since birth",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500))
                          ])),
                  SizedBox(height: 30),
                  Text("Types of Temperaments",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                  SizedBox(height: 30),
                  SizedBox(
                      child: Column(children: [
                    NavigatorButton("Easy", context),
                    SizedBox(height: 20),
                    NavigatorButton("Difficult", context),
                    SizedBox(height: 20),
                    NavigatorButton("Slow to warm up", context)
                  ]))
                ])));
  }
}

SizedBox NavigatorButton(String temperament, BuildContext context) {
  String imageLink = "";

  switch (temperament) {
    case ("Easy"):
      imageLink = "assets/images/dog.png";
      break;
    case ("Difficult"):
      imageLink = "assets/images/cat.png";
      break;
    case ("Slow to warm up"):
      imageLink = "assets/images/turtle.png";
      break;
    default:
      break;
  }

  return SizedBox(
      width: double.infinity,
      height: scaleHeight(context, 60),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              backgroundColor: Colors.white,
              side: BorderSide(
                style: BorderStyle.none,
              )),
          onPressed: () {
            Get.to(() => TemperamentExplain(temperament: temperament));
          },
          child: SizedBox(
              child: Row(children: [
            Image.asset(width: 30, height: 30, imageLink),
            SizedBox(width: 10),
            Text(temperament,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            Text(" temperament",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400))
          ]))));
}

class SlideWrapper extends StatefulWidget {
  const SlideWrapper({Key? key}) : super(key: key);

  @override
  State<SlideWrapper> createState() => _SlideWrapperState();
}

class _SlideWrapperState extends State<SlideWrapper>
    with TickerProviderStateMixin {
  late final AnimationController _FirstController = AnimationController(
    duration: const Duration(milliseconds: 2500),
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
    duration: const Duration(milliseconds: 2500),
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
    duration: const Duration(milliseconds: 2500),
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
    duration: const Duration(milliseconds: 2000),
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

  int curPage = 0;
  void setCurPage(int nextPage) {
    List controllerList = [
      _FirstController,
      _SecondController,
      _ThirdController,
      _FourthController
    ];

    AnimationController curController = controllerList[curPage];
    AnimationController nextController = controllerList[nextPage];

    setState(() {
      curPage = nextPage;
      curController.reset();
      nextController.forward();
    });
  }

  bool isOnFourth = false;
  void setIsOnFourth(bool state) {
    setState(() {
      isOnFourth = state;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _FirstController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _FirstController.dispose();
    _SecondController.dispose();
    _ThirdController.dispose();
    _FourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: double.infinity,
        height: height,
        color: Color(0xffFFF6DA),
        child: GestureDetector(
            onVerticalDragEnd: (DragEndDetails details) {
              // if (isOnFourth) {
              //   return;
              // }
              // if (details.velocity.pixelsPerSecond.dy < 0 && curPage < 3) {
              //   setCurPage(curPage + 1);
              //
              // } else if (details.velocity.pixelsPerSecond.dy > 0 &&
              //     curPage > 0) {
              //   setCurPage(curPage - 1);
              //
              // } else {
              //   return;
              // }
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: -1 * curPage * MediaQuery.of(context).size.height,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      gestureWrapper(
                          FirstSlide(context, _FirstAnimation.value, height),
                          setCurPage,
                          curPage),
                      gestureWrapper(
                          SecondSlide(context, _SecondAnimation.value, height),
                          setCurPage,
                          curPage),
                      gestureWrapper(
                          ThirdSlide(context, _ThirdAnimation.value, height),
                          setCurPage,
                          curPage),
                      FourthSlide(
                        curValue: _FourthAnimation.value,
                        setCurPage: setCurPage,
                      ),
                    ]),
                  ),
                ),
                Positioned(
                    top: 100,
                    left: 30,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_outlined,
                          color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                        return;
                      },
                    ))
              ],
            )));
  }
}

GestureDetector gestureWrapper(Widget comp, Function setCurPage, int curPage) {
  return GestureDetector(
      onVerticalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dy < 0 && curPage < 3) {
          setCurPage(curPage + 1);
        } else if (details.velocity.pixelsPerSecond.dy > 0 && curPage > 0) {
          setCurPage(curPage - 1);
        } else {
          return;
        }
      },
      child: comp);
}

Container FirstSlide(BuildContext context, double curValue, double height) {
  double titlePop = 0.1;
  double imagePop = 0.25;
  double firstStrPop = 0.4;
  double secondStrPop = 0.6;
  double thirdStrPop = 0.8;

  return Container(
      color: Color(0xffFFF6DA),
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          SizedBox(height: 130),
          Transform.translate(
            offset: Offset(0, 30 - min(curValue, titlePop) * 150),
            child: Opacity(
                opacity: min(titlePop, curValue) * 10,
                child: Text("1",
                    style: TextStyle(fontSize: 25, color: Color(0xff828282)))),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Transform.translate(
                  offset: Offset(0, 30 - min(curValue, titlePop) * 150),
                  child: Opacity(
                    opacity: min(titlePop, curValue) * 10,
                    child: SizedBox(
                        child: Column(children: [
                      Text("What is",
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w400)),
                      Text("temperament",
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w400))
                    ])),
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Transform.translate(
                      offset: Offset(0,
                          30 - max(0, min((curValue - imagePop), 0.2) * 150)),
                      child: Opacity(
                        opacity: max(0, min((curValue - imagePop), 0.2) * 5),
                        child: Image.asset(
                            "assets/images/humans_for_temperament.png"),
                      ),
                    )),
                SizedBox(height: 60),
                Transform.translate(
                  offset: Offset(
                      0, 30 - max(0, min((curValue - firstStrPop), 0.2) * 150)),
                  child: Opacity(
                    opacity: max(0, min((curValue - firstStrPop), 0.2) * 5),
                    child: Text("It is a person's own",
                        style:
                            TextStyle(fontSize: 25, color: Color(0xff828282))),
                  ),
                ),
                SizedBox(height: 15),
                Transform.translate(
                  offset: Offset(0,
                      30 - max(0, min((curValue - secondStrPop), 0.2) * 150)),
                  child: Opacity(
                      opacity: max(0, min((curValue - secondStrPop), 0.2) * 5),
                      child: Container(
                        color: Color.fromRGBO(255, 113, 127, 0.18),
                        padding: EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Text("unique characteristic",
                            style: TextStyle(
                                fontSize: 35, color: Color(0xffFF717F))),
                      )),
                ),
                SizedBox(height: 15),
                Transform.translate(
                  offset: Offset(
                      0, 30 - max(0, min((curValue - thirdStrPop), 0.2) * 150)),
                  child: Opacity(
                    opacity: max(0, min((curValue - thirdStrPop), 0.2) * 5),
                    child: Text("that he or she has since birth",
                        style:
                            TextStyle(fontSize: 25, color: Color(0xff828282))),
                  ),
                )
              ]),
        ],
      ));
}

Container SecondSlide(BuildContext context, double curValue, double height) {
  double titlePop = 0.1;
  double firstStrPop = 0.2;
  double secondStrPop = 0.3;
  double firstNavPop = 0.5;
  double secondNavPop = 0.6;
  double thirdNavPop = 0.7;
  double thirdStrPop = 0.9;

  return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          SizedBox(height: 130),
          Transform.translate(
            offset: Offset(0, 30 - min(curValue, titlePop) * 300),
            child: Opacity(
                opacity: min(titlePop, curValue) * 5,
                child: Text("2",
                    style: TextStyle(fontSize: 25, color: Color(0xff828282)))),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Transform.translate(
                  offset: Offset(
                      0, 30 - max(0, min((curValue - titlePop), 0.1) * 300)),
                  child: Opacity(
                    opacity: max(0, min((curValue - titlePop), 0.1) * 10),
                    child: Text("Types of Temperaments",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Transform.translate(
                      offset: Offset(
                          0,
                          30 -
                              max(0, min((curValue - firstStrPop), 0.1) * 300)),
                      child: Opacity(
                        opacity:
                            max(0, min((curValue - firstStrPop), 0.1) * 10),
                        child: Text("There are three temperaments",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                    )),
                SizedBox(height: 20),
                Transform.translate(
                  offset: Offset(
                      -30 + max(0, min((curValue - secondStrPop), 0.1) * 300),
                      0),
                  child: Opacity(
                    opacity: max(0, min((curValue - secondStrPop), 0.1) * 10),
                    child: Text("Let's have a deeper look!",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff828282))),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(children: [
                      Transform.translate(
                        offset: Offset(
                            -30 +
                                max(0,
                                    min((curValue - firstNavPop), 0.2) * 150),
                            0),
                        child: Opacity(
                            opacity:
                                max(0, min((curValue - firstNavPop), 0.2) * 5),
                            child: NavigatorButton("Easy", context)),
                      ),
                      SizedBox(height: 15),
                      Transform.translate(
                        offset: Offset(
                            -30 +
                                max(0,
                                    min((curValue - secondNavPop), 0.2) * 150),
                            0),
                        child: Opacity(
                            opacity:
                                max(0, min((curValue - secondNavPop), 0.2) * 5),
                            child: NavigatorButton("Difficult", context)),
                      ),
                      SizedBox(height: 15),
                      Transform.translate(
                        offset: Offset(
                            -30 +
                                max(0,
                                    min((curValue - thirdNavPop), 0.2) * 150),
                            0),
                        child: Opacity(
                            opacity:
                                max(0, min((curValue - thirdNavPop), 0.2) * 5),
                            child: NavigatorButton("Slow to warm up", context)),
                      )
                    ])),
                SizedBox(height: 36),
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Transform.translate(
                      offset: Offset(0,
                          30 - max(0, min((curValue - titlePop), 0.1) * 300)),
                      child: Opacity(
                        opacity:
                            max(0, min((curValue - thirdStrPop), 0.1) * 10),
                        child: Text(
                            "Children may fall into one of the three types. But often have varying behavior across the common temperament traits.",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ))
              ]),
        ],
      ));
}

Container ThirdSlide(BuildContext context, double curValue, double height) {
  double titlePop = 0.2;
  double firstBoxPop = 0.3;
  double leftStrPop = 0.5;
  double rightStrPop = 0.7;

  return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          SizedBox(height: 130),
          Opacity(
              opacity: min(titlePop, curValue) * 5,
              child: Text("3",
                  style: TextStyle(fontSize: 25, color: Color(0xff828282)))),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Transform.translate(
                  offset: Offset(
                      0, 30 - max(0, min((curValue - titlePop), 0.1) * 300)),
                  child: Opacity(
                    opacity: max(0, min((curValue - titlePop), 0.1) * 10),
                    child: SizedBox(
                        child: Column(children: [
                      Text("Why does",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400)),
                      Text("temperament matter?",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400))
                    ])),
                  ),
                ),
                SizedBox(height: 50),
                Transform.translate(
                  offset: Offset(
                      0, 30 - max(0, min((curValue - firstBoxPop), 0.2) * 150)),
                  child: Opacity(
                    opacity: max(0, min((curValue - firstBoxPop), 0.2) * 5),
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, left: 30, right: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Column(children: [
                          Text("Temperament describes",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Text("the way we approach and",
                              style: TextStyle(
                                  fontSize: 24, color: Color(0xffFF717F))),
                          SizedBox(height: 10),
                          Text("react to the world",
                              style: TextStyle(
                                  fontSize: 24, color: Color(0xffFF717F)))
                        ])),
                  ),
                ),
                SizedBox(height: 50),
                Transform.translate(
                  offset: Offset(
                      -30 + max(0, min((curValue - leftStrPop), 0.2) * 150), 0),
                  child: Opacity(
                    opacity: max(0, min((curValue - leftStrPop), 0.2) * 5),
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('It is our own personal "style"',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10),
                              Text("that is present from birth",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500))
                            ])),
                  ),
                ),
                SizedBox(height: 30),
                Transform.translate(
                  offset: Offset(
                      30 - max(0, min((curValue - rightStrPop), 0.2) * 150), 0),
                  child: Opacity(
                    opacity: max(0, min((curValue - rightStrPop), 0.2) * 5),
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Temperament is",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10),
                              Text("an important feature of",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10),
                              Text("social and emotional health",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500))
                            ])),
                  ),
                )
              ]),
        ],
      ));
}

class FourthSlide extends StatefulWidget {
  const FourthSlide(
      {Key? key, required this.curValue, required this.setCurPage})
      : super(key: key);

  final double curValue;
  final Function(int nextPage) setCurPage;

  @override
  State<FourthSlide> createState() => _FourthSlideState();
}

class _FourthSlideState extends State<FourthSlide> {
  double curPosition = 0;
  void setCurPosition(double newPosition) {
    setState(() {
      curPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    double curValue = widget.curValue;
    double titlePop = 0.1;
    double imagePop = 0.3;
    double leftStrPop = 0.4;
    double rightStrPop = 0.5;
    double elsePop = 0.7;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            Offset delta = details.delta;
            if (curPosition + delta.dy > 10) {
              setCurPosition(0);
              widget.setCurPage(2);
              return;
            }
            if (curPosition + delta.dy < -600) {
              return;
            }
            setCurPosition(curPosition + delta.dy);
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: curPosition,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffFFF6DA),
                      child: Column(
                        children: [
                          SizedBox(height: 130),
                          Opacity(
                            opacity: min(titlePop, curValue) * 5,
                            child: Text("4",
                                style: TextStyle(
                                    fontSize: 25, color: Color(0xff828282))),
                          ),
                          Column(children: [
                            SizedBox(height: 60),
                            Transform.translate(
                              offset: Offset(
                                  0,
                                  30 -
                                      max(
                                          0,
                                          min((curValue - titlePop), 0.1) *
                                              300)),
                              child: Opacity(
                                opacity: max(
                                    0, min((curValue - titlePop), 0.1) * 10),
                                child: SizedBox(
                                    child: Column(children: [
                                  SizedBox(
                                      child: Text("Compatibility between",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400))),
                                  SizedBox(
                                      child: Text("adult-child temperament",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400))),
                                ])),
                              ),
                            ),
                            SizedBox(height: 50),
                            Transform.translate(
                              offset: Offset(
                                  -30 +
                                      max(
                                          0,
                                          min((curValue - leftStrPop), 0.2) *
                                              150),
                                  0),
                              child: Opacity(
                                opacity: max(
                                    0, min((curValue - leftStrPop), 0.1) * 10),
                                child: Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Each cargive is also",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3)),
                                          Text("unique in his or her own",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3)),
                                          Text("temperament",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3))
                                        ])),
                              ),
                            ),
                            SizedBox(height: 10),
                            Transform.translate(
                              offset: Offset(
                                  0,
                                  -30 +
                                      max(
                                          0,
                                          min((curValue - imagePop), 0.1) *
                                              300)),
                              child: Opacity(
                                  opacity: max(
                                      0, min((curValue - imagePop), 0.1) * 10),
                                  child: Image.asset(
                                      "assets/images/broken_heart.png")),
                            ),
                            SizedBox(height: 10),
                            Transform.translate(
                              offset: Offset(
                                  30 -
                                      max(
                                          0,
                                          min((curValue - rightStrPop), 0.1) *
                                              300),
                                  0),
                              child: Opacity(
                                opacity: max(
                                    0, min((curValue - rightStrPop), 0.1) * 10),
                                child: Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("The compatibility",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3)),
                                          Text(
                                              "between adult-child temperament",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3)),
                                          Text("can affect the quality of",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3)),
                                          Text("relationships.",
                                              style: TextStyle(
                                                  fontSize: 20, height: 1.3))
                                        ])),
                              ),
                            ),
                            SizedBox(height: 60),
                            Transform.translate(
                              offset: Offset(
                                  0,
                                  30 -
                                      max(
                                          0,
                                          min((curValue - elsePop), 0.1) *
                                              300)),
                              child: Opacity(
                                opacity:
                                    max(0, min((curValue - elsePop), 0.1) * 10),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Column(children: [
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      color: Color.fromRGBO(
                                                          255, 113, 127, 0.18),
                                                      padding: EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 5,
                                                          bottom: 5),
                                                      child: Text(
                                                          "Goodness Of Fit",
                                                          style: TextStyle(
                                                              fontSize: 30)),
                                                    ),
                                                    Positioned(
                                                        left: 10,
                                                        top: -10,
                                                        child: Image.asset(
                                                            "assets/images/quote_left.png")),
                                                    Positioned(
                                                        right: 10,
                                                        bottom: -10,
                                                        child: Image.asset(
                                                            "assets/images/quote_right.png"))
                                                  ]),
                                            ],
                                          )),
                                      SizedBox(height: 20),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "It happens when an adult's expectations and ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    height: 1.3)),
                                            TextSpan(
                                                text:
                                                    "methods of caregiving match the child's personal style and abilities",
                                                style: TextStyle(
                                                    color: Color(0xffFF717F),
                                                    fontSize: 20,
                                                    height: 1.3))
                                          ]))),
                                      SizedBox(height: 30),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Text(
                                              "The goodness of fit does not require that adults and children have matching temperaments.",
                                              style: TextStyle(
                                                  height: 1.3,
                                                  color: Colors.black,
                                                  fontSize: 20))),
                                      SizedBox(height: 30),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "The caregiver does not have to change who they are naturally, they can simply",
                                              style: TextStyle(
                                                  height: 1.3,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            TextSpan(
                                                text:
                                                    " alter or adjust caregiving methods",
                                                style: TextStyle(
                                                    height: 1.3,
                                                    color: Color(0xffFF717F),
                                                    fontSize: 20)),
                                            TextSpan(
                                                text:
                                                    " to be a positive support to their child's natural way of responding to the world.",
                                                style: TextStyle(
                                                    height: 1.3,
                                                    color: Colors.black,
                                                    fontSize: 20))
                                          ]))),
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: 50, bottom: 50),
                                          child: Column(children: [
                                            Text("For your goodness of fit,",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff5F5F5F))),
                                            SizedBox(height: 10),
                                            Text("we will help you out!",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff5F5F5F)))
                                          ])),
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                NavigatorToAddTemp(20)
                                              ]))
                                    ])),
                              ),
                            )
                          ]),
                        ],
                      )),
                ),
              ),
            ],
          )),
    );
  }
}

Container NavigatorToAddTemp(double fontSize) {
  return Container(
    height: 70,
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            backgroundColor: Colors.white,
            side: BorderSide(
              style: BorderStyle.none,
            )),
        onPressed: () {
          Get.to(() => PopUpSelect());
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text("Add Temperament info",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500)),
        )),
  );
}
