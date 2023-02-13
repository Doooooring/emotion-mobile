import "dart:developer";

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, required this.isLoading, required this.height})
      : super(key: key);
  final bool isLoading;
  final double height;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      return Container(height: 0);
    }

    return Container(
      width: double.infinity,
      height: widget.height,
      child: Offstage(
          offstage: widget.isLoading,
          child: Stack(children: <Widget>[
            Opacity(
              opacity: 0.1,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
            Center(
                child: Stack(children: [
              Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProgressIndicatorWrapper(isLoading: widget.isLoading),
                      SizedBox(height: 20),
                      TextAnimation(isLoading: widget.isLoading)
                    ],
                  ))
            ]))
          ])),
    );
  }
}

class ProgressIndicatorWrapper extends StatefulWidget {
  const ProgressIndicatorWrapper({Key? key, required this.isLoading})
      : super(key: key);

  final bool isLoading;

  @override
  State<ProgressIndicatorWrapper> createState() =>
      _ProgressIndicatorWrapperState();
}

class _ProgressIndicatorWrapperState extends State<ProgressIndicatorWrapper>
    with TickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(vsync: this, duration: Duration(seconds: 10))
        ..repeat(reverse: false);
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 600).animate(controller)
        ..addListener(() {
          if (mounted) {
            setState(() {});
          }
        });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ProgressIndicator(animation.value, widget.isLoading));
  }
}

Container ProgressIndicator(double animationValue, bool isLoading) {
  List<String> emotionList = [
    "happy1",
    "calm1",
    "excited3",
    "content3",
    "angry2",
    "goodSurprised2"
  ];

  int idx = (animationValue / 60).floor() % 6;

  String curEmotion = 'assets/images/${emotionList[idx]}.png';

  int iteration = (animationValue / 60).floor();

  double height = (animationValue - 60 * iteration - 30).abs();

  log(height.toString());

  return Container(
      child: Transform.translate(
          offset: Offset(0, height),
          child: Image.asset(height: 70, width: 70, curEmotion)));
}

List<String> commentList = [
  '',
  'a',
  'an',
  'ana',
  'anal',
  'analy',
  'analyz',
  'analyzi',
  'analyzin',
  'analyzing',
  'analyzing ',
  'analyzing e',
  'analyzing em',
  'analyzing emo',
  'analyzing emot',
  'analyzing emoti',
  'analyzing emotio',
  'analyzing emotion',
  'analyzing emotion.',
  'analyzing emotion..',
  'analyzing emotion...',
  'analyzing emotion....',
  'analyzing emotion....',
  'analyzing emotion....',
  'analyzing emotion....',
  'analyzing emotion....'
];

class TextAnimation extends StatefulWidget {
  const TextAnimation({Key? key, required this.isLoading}) : super(key: key);

  final bool isLoading;

  @override
  State<TextAnimation> createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1800))
        ..repeat(reverse: false);
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 24).animate(controller)
        ..addListener(() {
          if (mounted) {
            setState(() {});
          }
        });

  @override
  Widget build(BuildContext context) {
    bool state = animation.value.round() % 2 == 0;
    int curLength = animation.value.round();
    String curText = commentList[curLength];

    return SizedBox(
        width: 180,
        height: 30,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '${curText}'),
          Container(
              width: 7, height: 20, color: state ? Colors.grey : Colors.black)
        ]));
  }
}
