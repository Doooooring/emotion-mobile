import 'package:aeye/component/common/loading_proto.dart';
import 'package:aeye/controller/childController.dart';
import 'package:aeye/page/advice/temperament_result.dart';
import "package:aeye/services/advice.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

// class QuestionContent {
//   QuestionContent(this.content, this.score);
//   final String content;
//   final int score;
//   fromJson(json){
//     return QuestionContent(json["content"], json["score"]);
//   }
// }
//
// class Question {
//   Question(this.id, this.title, this.left, this.right);
//   final int id;
//   final String title;
//   final QuestionContent left;
//   final QuestionContent right;
// }

AdviceServices adviceServices = AdviceServices();

List questionList = [
  {
    "id": 1,
    "title": "Activity Level",
    "left": {"content": "Highly Active", "score": []},
    "right": {
      "content": "Less Active",
      "score": [1]
    }
  },
  {
    "id": 2,
    "title": "Distractibility",
    "left": {"content": "Easily Distracted", "score": []},
    "right": {"content": "Less Distracted", "score": []}
  },
  {
    "id": 3,
    "title": "Intensity",
    "left": {
      "content": "Intense Personality",
      "score": [2]
    },
    "right": {
      "content": "Relaxed Personality",
      "score": [0, 1]
    }
  },
  {
    "id": 4,
    "title": "Regularity",
    "left": {
      "content": "Highly Regular",
      "score": [0]
    },
    "right": {
      "content": "More Spontaneous",
      "score": [2]
    }
  },
  {
    "id": 5,
    "title": "Sensitivity",
    "left": {"content": "Highly sensitive", "score": []},
    "right": {"content": "Less Sensitive", "score": []}
  },
  {
    "id": 6,
    "title": "Approachability",
    "left": {
      "content": "Highly Approachable",
      "score": [0]
    },
    "right": {
      "content": "Less Approachable",
      "score": [1, 2]
    }
  },
  {
    "id": 7,
    "title": "Adaptability",
    "left": {
      "content": "Highly Adaptable",
      "score": [0]
    },
    "right": {
      "content": "Less Adaptable",
      "score": [1, 2]
    },
  },
  {
    "id": 8,
    "title": "Persistence",
    "left": {
      "content": "Highly Persistent",
      "score": [0]
    },
    "right": {
      "content": "Less Persistent",
      "score": [1, 2]
    }
  },
  {
    "id": 9,
    "title": "Mood",
    "left": {
      "content": "Positive Mood",
      "score": [0]
    },
    "right": {
      "content": "Serious Mood",
      "score": [1, 2]
    }
  }
];

class TemperamentTest extends StatefulWidget {
  const TemperamentTest({Key? key, required this.child, required this.age})
      : super(key: key);

  final String child;
  final int age;

  @override
  State<TemperamentTest> createState() => _TemperamentTestState();
}

class _TemperamentTestState extends State<TemperamentTest>
    with TickerProviderStateMixin {
  ChildController childController = Get.find();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;
  setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  int curInd = 0;
  addCurInd() {
    setState(() {
      curInd += 1;
    });
  }

  int easyScore = 0;
  addEasyScore() {
    setState(() {
      easyScore += 1;
    });
  }

  int slowToWarmUpScore = 0;
  addSlowToWarmUpScore() {
    setState(() {
      slowToWarmUpScore += 1;
    });
  }

  int difficultScore = 0;
  addDifficultScore() {
    setState(() {
      difficultScore += 1;
    });
  }

  String getTemperament(int easy, int slowTo, int difficult) {
    List<int> numList = [easy, slowTo, difficult];
    numList.sort();
    int maxNum = numList[2];
    if (maxNum == easy) {
      return "Easy";
    } else if (maxNum == slowTo) {
      return "Slow to warm up";
    } else {
      return "Difficult";
    }
  }

  void boxClicked(List<dynamic> scores) async {
    scores.forEach((score) {
      switch (score) {
        case (0):
          addEasyScore();
          break;
        case (1):
          addSlowToWarmUpScore();
          break;
        case (2):
          addDifficultScore();
          break;
      }
    });
    if (curInd == 8) {
      setIsLoading();
      String curTemp =
          getTemperament(easyScore, slowToWarmUpScore, difficultScore);
      await adviceServices.addChild(
          widget.child, curTemp, widget.age, childController);
      // await Timer(Duration(seconds: 2), () {
      //   Get.to(TemperamentResult(child: widget.child, temperament: curTemp));
      // });
      Get.to(TemperamentResult(child: widget.child, temperament: curTemp));
      setIsLoading();
      return;
    }
    addCurInd();
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Map curQuestion = questionList[curInd];

    String title = curQuestion["title"];
    Map<String, Object> left = curQuestion["left"] as Map<String, Object>;
    Map<String, Object> right = curQuestion["right"] as Map<String, Object>;

    double opacity = 0.5 + (_animation.value - 0.5).abs();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 50,
          titleSpacing: 0,
          backgroundColor: Color(0xffFFF2CB),
          elevation: 0.1,
          centerTitle: false,
          title: Container(
            child: Row(
              children: [
                SizedBox(width: 20),
                Text("Temperament test",
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
        body: isLoading
            ? Loading(isLoading: isLoading, height: double.infinity)
            : Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(height: 30),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [0, 1, 2, 3, 4, 5, 6, 7, 8].map((ind) {
                              return Container(
                                margin: EdgeInsets.only(left: 2, right: 2),
                                color: curInd >= ind
                                    ? Color(0xffFFDD67)
                                    : Color(0xffE2E2E2),
                                width: 30,
                                height: 4,
                              );
                            }).toList())),
                    SizedBox(height: 80),
                    SizedBox(
                        child: Text("${widget.child} is...",
                            style: TextStyle(
                                fontSize: 30, color: Color(0xffFF717F)))),
                    SizedBox(height: 100),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          GestureDetector(
                            onTap: () {
                              boxClicked(left["score"] as List<dynamic>);
                            },
                            child: Opacity(
                              opacity: opacity,
                              child: Container(
                                  width: 160,
                                  height: 160,
                                  padding: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFD8CB),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(0, 0))
                                      ],
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: (left["content"] as String)
                                          .split(" ")
                                          .map((str) {
                                        return Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                            ),
                                            child: Opacity(
                                              opacity: _controller.value,
                                              child: Text(str,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ));
                                      }).toList())),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              boxClicked(right["score"] as List<dynamic>);
                            },
                            child: Opacity(
                              opacity: opacity,
                              child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(0, 0))
                                      ],
                                      color: Color(0xffFFD8CB),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: (right["content"] as String)
                                          .split(" ")
                                          .map((str) {
                                        return Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                            ),
                                            child: Opacity(
                                              opacity: _controller.value,
                                              child: Text(str,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ));
                                      }).toList())),
                            ),
                          )
                        ]))
                  ])));
  }
}
