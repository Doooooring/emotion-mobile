import "dart:math";

import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1200),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double value = _animation.value;

    double imagePop = 0.2;
    double aPop = 0.4;
    double dashPop = 0.6;
    double eFirstPop = 0.7;
    double yPop = 0.75;
    double eSecondPop = 0.8;

    double fontScale(double mini) {
      return (min(1, max(0, (value - mini) * 5)));
    }

    return WillPopScope(
        child: Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 300,
                          height: 300,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Offstage(
                                  offstage: value < imagePop,
                                  child: Opacity(
                                      opacity: min(
                                          1, max(0, (value - imagePop) * 5)),
                                      child: Image.asset(
                                          "assets/images/logo.png")),
                                )
                              ])),
                      SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Offstage(
                                  offstage: value < aPop,
                                  child: Opacity(
                                    opacity: fontScale(aPop),
                                    child: Text("A",
                                        style: TextStyle(
                                            color: Color(0xffFED754),
                                            fontSize: 80 * fontScale(aPop),
                                            fontFamily: "ITC_Avant_Garde")),
                                  ),
                                ),
                                Offstage(
                                    offstage: value < dashPop,
                                    child: Opacity(
                                      opacity: fontScale(dashPop),
                                      child: Text("-",
                                          style: TextStyle(
                                              color: Color(0xffFED754),
                                              fontSize: 80 * fontScale(dashPop),
                                              fontFamily: "ITC_Avant_Garde")),
                                    )),
                                Offstage(
                                    offstage: value < eFirstPop,
                                    child: Opacity(
                                      opacity: fontScale(eFirstPop),
                                      child: Text("e",
                                          style: TextStyle(
                                              color: Color(0xffFED754),
                                              fontSize:
                                                  80 * fontScale(eFirstPop),
                                              fontFamily: "ITC_Avant_Garde")),
                                    )),
                                Offstage(
                                    offstage: value < yPop,
                                    child: Opacity(
                                      opacity: fontScale(yPop),
                                      child: Text("y",
                                          style: TextStyle(
                                              color: Color(0xffFED754),
                                              fontSize: 80 * fontScale(yPop),
                                              fontFamily: "ITC_Avant_Garde")),
                                    )),
                                Offstage(
                                    offstage: value < eSecondPop,
                                    child: Opacity(
                                      opacity: fontScale(eSecondPop),
                                      child: Text("e",
                                          style: TextStyle(
                                              color: Color(0xffFED754),
                                              fontSize:
                                                  80 * fontScale(eSecondPop),
                                              fontFamily: "ITC_Avant_Garde")),
                                    )),
                              ])),
                    ]))),
        onWillPop: () async => false);
  }
}
