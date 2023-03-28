import "package:aeye/component/common/button_back.dart";
import "package:aeye/controller/sizeController.dart";
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
            print("here");
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
  late final AnimationController _SlideController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _SlideAnimation = CurvedAnimation(
    parent: _SlideController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _FirstController = AnimationController(
    duration: const Duration(milliseconds: 1000),
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
    duration: const Duration(milliseconds: 1000),
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
    duration: const Duration(milliseconds: 1000),
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
    duration: const Duration(milliseconds: 1000),
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
  void dispose() {
    _SlideController.dispose();
    _FirstController.dispose();
    _SecondController.dispose();
    _ThirdController.dispose();
    _FourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
              if (isOnFourth) {
                return;
              }
              print(details.delta.dx);

              if (details.delta.dx > 0 && curPage < 3) {
                setCurPage(curPage + 1);
              } else if (details.delta.dx < 0 && curPage > 0) {
                setCurPage(curPage - 1);
              } else {
                return;
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: -1 * curPage * MediaQuery.of(context).size.height,
                  child: SizedBox(
                    child: Column(children: [
                      FirstSlide(context, _FirstAnimation.value, height),
                      SecondSlide(context, _SecondAnimation.value, height),
                      ThirdSlide(context, _ThirdAnimation.value, height),
                      FourthSlide(context, _FourthAnimation.value)
                    ]),
                  ),
                )
              ],
            )));
  }
}

Container FirstSlide(BuildContext context, double curValue, double height) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(
        top: 50,
      ),
      child: Column(children: [
        Text("1"),
        SizedBox(
            child: Column(children: [Text("What is"), Text("temperament")])),
        SizedBox(height: 30),
        Image.asset("assets/images/humans_for_temperament.png"),
        SizedBox(height: 30),
        Text("It is a person's own"),
        Container(
            color: Color.fromRGBO(255, 113, 127, 0.18),
            child: Text("unique characteristic",
                style: TextStyle(color: Color(0xffFF717F)))),
        Text("that he or she has since birth")
      ]));
}

Container SecondSlide(BuildContext context, double curValue, double height) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(top: 50),
      child: Column(children: [
        Text("2"),
        Text("Types of Temperaments"),
        SizedBox(height: 50),
        Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text("There are three temperaments")),
        SizedBox(height: 50),
        Text("Let's have a deeper look!"),
        SizedBox(
            child: Column(children: [
          NavigatorButton("Easy", context),
          SizedBox(height: 20),
          NavigatorButton("Difficult", context),
          SizedBox(height: 20),
          NavigatorButton("Slow to warm up", context)
        ])),
        Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Text(
                "Children may fall into one of the three types. But often have varying behavior across the common temperament traits."))
      ]));
}

Container ThirdSlide(BuildContext context, double curValue, double height) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: EdgeInsets.only(top: 50),
      child: Column(children: [
        SizedBox(
            child: Column(
                children: [Text("Why does"), Text("temperament matter?")])),
        SizedBox(height: 50),
        Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Column(children: [
              Text("Temperament describes"),
              Text("the way we approach and"),
              Text("react to the world")
            ])),
        SizedBox(height: 30),
        SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text('It is our own personal "style"'),
              Text("that is present from birth")
            ])),
        SizedBox(height: 10),
        SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text("Temperament is"),
          Text("an important feature of"),
          Text("social and emotional health")
        ]))
      ]));
}

SingleChildScrollView FourthSlide(BuildContext context, double curValue) {
  return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(children: [
            Text("4"),
            SizedBox(height: 30),
            SizedBox(child: Text("Compatibility between")),
            SizedBox(child: Text("adult-child temperament")),
            SizedBox(
                child: Column(children: [
              Text("Each cargive is also"),
              Text("unique in his or her own"),
              Text("temperament")
            ])),
            Image.asset("assets/images/broken_heart.png"),
            SizedBox(
                child: Column(children: [
              Text("The compatibility"),
              Text("between adult-child temperament"),
              Text("can affect the quality of"),
              Text("relationships.")
            ])),
            SizedBox(height: 80),
            SizedBox(
                width: double.infinity,
                height: 100,
                child: Stack(children: [
                  Container(
                    color: Color.fromRGBO(255, 113, 127, 0.18),
                    child: Text("Goodness Of Fit"),
                  ),
                  Positioned(
                      child: Image.asset("assets/images/quote_left.png")),
                  Positioned(
                      child: Image.asset("assets/images/quote_right.png"))
                ])),
            SizedBox(
                child: RichText(
                    text: TextSpan(children: [
              TextSpan(text: "It happens when an adult's expectations and "),
              TextSpan(
                  text:
                      "methods of caregiving match the child's personal style and abilities",
                  style: TextStyle(color: Color(0xffFF717F)))
            ]))),
            SizedBox(height: 30),
            SizedBox(
                child: Text(
                    "The goodness of fit does not require that adults and children have matching temperaments.")),
            SizedBox(height: 30),
            SizedBox(
                child: RichText(
                    text: TextSpan(children: [
              TextSpan(
                  text:
                      "The caregiver does not have to change who they are naturally, they can simply"),
              TextSpan(
                  text: "alter or adjust caregiving methods",
                  style: TextStyle(color: Color(0xffFF717F))),
              TextSpan(
                  text:
                      "to be a positive support to their child's natural way of responding to the world.")
            ]))),
            Container(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Column(children: [
                  Text("For your goodness of fit,"),
                  Text("we will help you out!")
                ])),
            Container(
                padding: EdgeInsets.only(left: 60, right: 60),
                child: Row(children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset.zero,
                                blurRadius: 10.0,
                                spreadRadius: -8)
                          ]),
                      child: Text("Add Temperament info"))
                ]))
          ])));
}
