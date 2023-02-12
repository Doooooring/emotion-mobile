import 'dart:async';

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
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200))
        ..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
          begin: Alignment.bottomCenter, end: Alignment.topCenter)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate))
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int curIdx = 0;
  void setCurIdx(nextIdx) {
    setState(() {
      curIdx = nextIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: AlignTransition(
          alignment: _animation,
          child: ProgressIndicator(curIdx, setCurIdx, widget.isLoading)),
    );
  }
}

Container ProgressIndicator(
    int idx, void Function(int) setCurIdx, bool isLoading) {
  List<String> emotionList = [
    "happy1",
    "calm1",
    "excited3",
    "content3",
    "angry2",
    "goodSurprised2"
  ];
  String curEmotion = 'assets/images/${emotionList[idx]}.png';

  void setEmotion() {
    if (isLoading == true) {
      return;
    }

    Timer(Duration(milliseconds: 400), () {
      setCurIdx((idx + 1) % 5);
    });
  }

  setEmotion();

  return Container(child: Image.asset(height: 70, width: 70, curEmotion));
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
          setState(() {});
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
