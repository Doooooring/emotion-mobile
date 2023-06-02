import "package:aeye/component/common/loading_proto.dart";
import "package:aeye/page/advice/ai_result.dart";
import "package:aeye/services/advice.dart";
import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import "package:get/get.dart";

AdviceServices adviceServices = AdviceServices();

class AiChatting extends StatefulWidget {
  const AiChatting(
      {Key? key,
      required this.id,
      required this.child,
      required this.temperament,
      required this.age})
      : super(key: key);

  final String id;
  final String child;
  final String temperament;
  final int age;

  @override
  State<AiChatting> createState() => _AiChattingState();
}

class _AiChattingState extends State<AiChatting> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  List<Widget> commentBody = [];
  void setCommentBody(Widget comment) {
    setState(() {
      commentBody.add(comment);
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollDown();
    });
  }

  String curChild = "";
  void setCurChild(String child) {
    setState(() {
      curChild = child;
    });
  }

  String curAge = "";
  void setCurAge(String age) {
    setState(() {
      curAge = age;
    });
  }

  String curTemperament = "";
  void setCurTemperament(String temperament) {
    setState(() {
      curTemperament = temperament;
    });
  }

  String curProblem = "";
  void setCurProblem(String problem) {
    setState(() {
      curProblem = problem;
    });
  }

  String curStep = "init";
  /**
   * init
   * name check
   * age check
   * temperament check
   * problem check
   * */
  void setCurStep(String nextStep) {
    setState(() {
      curStep = nextStep;
    });
  }

  void userInput(String input) {
    if (curStep == "nameCheck") {
      setCurChild(input);
      setCurStep("ageCheck");
      setCommentBody(ChattingRow("user", UserWrapper(Text(input))));
      setCommentBody(BotAgeCheck(input));
    } else if (curStep == "ageCheck") {
      setCurAge(input);
      setCurStep("temperamentCheck");
      setCommentBody(ChattingRow("user", UserWrapper(Text(input))));
      setCommentBody(BotTemperamentCheck(curChild));
      setCommentBody(ChattingRow(
          "user",
          TemperamentButtonWrapper(
            setCommentBody: setCommentBody,
            setCurStep: setCurStep,
            setCurTemperament: setCurTemperament,
          )));
    } else if (curStep == "problemCheck") {
      setCurProblem(input);
      setCurStep("end");
      setCommentBody(ChattingRow("user", UserWrapper(Text(input))));
      setCommentBody(BotHmm());
      setCommentBody(ViewSolution(
          id: widget.id,
          name: curChild,
          age: curAge,
          temperament: curTemperament,
          problem: curProblem));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (commentBody.length == 0) {
      setCommentBody(ChattingRow("bot", BotFirst(widget.child)));
      setCommentBody(ButtonWrapper(
        child: widget.child,
        temperament: widget.temperament,
        age: widget.age.toString(),
        setCurStep: setCurStep,
        setCurTemperament: setCurTemperament,
        setCurChild: setCurChild,
        setCurAge: setCurAge,
        setCommentBody: setCommentBody,
      ));
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leadingWidth: 50,
          titleSpacing: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              icon:
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
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
                AeyeIcon(Colors.white),
                SizedBox(width: 15),
                Text("A-eye",
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
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              removeFocus(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(children: commentBody)))),
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 60,
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
                                  onTap: () {
                                    _scrollDown();
                                  },
                                  controller: controller,
                                  scrollPadding: EdgeInsets.all(0),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Type a message",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(50, 50, 50, 0.4)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.white))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                side: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xffFF717F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(2),
                                          width: 25,
                                          height: 25,
                                          child: Image.asset(
                                            "assets/images/send_Icon.png",
                                          ))
                                    ])),
                            onPressed: () async {
                              userInput(controller.text);
                              controller.text = "";
                            },
                          )
                        ],
                      )),
                ]),
              ),
            )));
  }
}

class StateWrapper extends StatefulWidget {
  const StateWrapper({Key? key, required this.content, required this.state})
      : super(key: key);

  final Widget content;
  final bool state;

  @override
  State<StateWrapper> createState() => _StateWrapperState();
}

class _StateWrapperState extends State<StateWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.state ? widget.content : Container(width: 0, height: 0);
  }
}

Row CommentInput(TextEditingController controller, Function scrollDown) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            onTap: () {
              print("is on tap");
              scrollDown();
            },
            controller: controller,
            scrollPadding: EdgeInsets.all(0),
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
                hintText: "Type a message...",
                labelStyle: TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white))),
          )
        ])),
  ]);
}

class TemperamentButtonWrapper extends StatefulWidget {
  const TemperamentButtonWrapper(
      {Key? key,
      required this.setCurTemperament,
      required this.setCommentBody,
      required this.setCurStep})
      : super(key: key);

  final void Function(String) setCurTemperament;
  final void Function(Widget) setCommentBody;
  final void Function(String) setCurStep;

  @override
  State<TemperamentButtonWrapper> createState() =>
      _TemperamentButtonWrapperState();
}

class _TemperamentButtonWrapperState extends State<TemperamentButtonWrapper> {
  String? curCheck = null;
  setCurCheck(String state) {
    setState(() {
      curCheck = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChattingRow(
        "user",
        UserWrapper(
          Row(children: [
            Container(
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(
                          style: BorderStyle.none,
                        )),
                    onPressed: () async {
                      setCurCheck("Easy");
                      widget.setCurStep("problemCheck");
                      widget.setCurTemperament("Easy");
                      widget.setCommentBody(ChattingRow(
                          "bot",
                          BotWrapper(Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text("Tell me about the problem briefly",
                                style: TextStyle(fontSize: 15, height: 1.5)),
                          ))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Easy"
                              ? Color(0xffFFA8A6)
                              : Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text("easy",
                            style: TextStyle(
                                color: curCheck == "Easy"
                                    ? Colors.white
                                    : Color(0xff72777A)))))),
            SizedBox(width: 10),
            Container(
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(
                          style: BorderStyle.none,
                        )),
                    onPressed: () async {
                      setCurCheck("Difficult");
                      widget.setCurStep("problemCheck");
                      widget.setCurTemperament("Difficult");
                      widget.setCommentBody(ChattingRow(
                          "bot",
                          BotWrapper(Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text("Tell me about the problem briefly",
                                style: TextStyle(fontSize: 15, height: 1.5)),
                          ))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Difficult"
                              ? Color(0xffFFA8A6)
                              : Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text("difficult",
                            style: TextStyle(
                                color: curCheck == "Difficult"
                                    ? Colors.white
                                    : Color(0xff72777A)))))),
            SizedBox(width: 10),
            Container(
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(
                          style: BorderStyle.none,
                        )),
                    onPressed: () async {
                      setCurCheck("Slow-to-warm-up");
                      widget.setCurStep("problemCheck");
                      widget.setCurTemperament("Slow-to-warm-up");
                      widget.setCommentBody(ChattingRow(
                          "bot",
                          BotWrapper(Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text("Tell me about the problem briefly",
                                style: TextStyle(fontSize: 15, height: 1.5)),
                          ))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Slow-to-warm-up"
                              ? Color(0xffFFA8A6)
                              : Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text("slow-to-warm-up",
                            style: TextStyle(
                                color: curCheck == "Slow-to-warm-up"
                                    ? Colors.white
                                    : Color(0xff72777A))))))
          ]),
        ));
  }
}

class ViewSolution extends StatefulWidget {
  const ViewSolution(
      {Key? key,
      required this.id,
      required this.name,
      required this.age,
      required this.temperament,
      required this.problem})
      : super(key: key);

  final String id;
  final String name;
  final String age;
  final String temperament;
  final String problem;

  @override
  State<ViewSolution> createState() => _ViewSolutionState();
}

class _ViewSolutionState extends State<ViewSolution> {
  bool isLoading = true;
  void setIsLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  String title = "";
  void setTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  List<void> solutions = [];
  void setSolutions(List<void> newSolutions) {
    setState(() {
      solutions = newSolutions;
    });
  }

  _asyncMethod() async {
    setIsLoading(true);
    List result = await adviceServices.getAdvice(
        widget.name, int.parse(widget.age), widget.temperament, widget.problem);
    print("is async method");
    print(result);
    setSolutions(result);

    setIsLoading(false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChattingRow(
        "bot",
        BotWrapper(Column(children: [
          SizedBox(height: 10),
          isLoading
              ? Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ProgressIndicatorWrapper(isLoading: isLoading))
              : SizedBox(height: 0),
          isLoading
              ? SizedBox(height: 0)
              : Container(
                  child: Column(
                    children: [
                      Text("Here are solutions",
                          style: TextStyle(fontSize: 15, height: 1.5)),
                      SizedBox(height: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            style: BorderStyle.none,
                          )),
                          onPressed: () async {
                            print(solutions);
                            Get.back();
                            Get.to(AiResult(solutions: solutions));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFDD67),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Text("View solutions",
                                  style: TextStyle(color: Colors.white)))),
                    ],
                  ),
                )
        ])));
  }
}

class ButtonWrapper extends StatefulWidget {
  const ButtonWrapper(
      {Key? key,
      required this.child,
      required this.temperament,
      required this.age,
      required this.setCurStep,
      required this.setCurChild,
      required this.setCurAge,
      required this.setCurTemperament,
      required this.setCommentBody})
      : super(key: key);

  final String child;
  final String temperament;
  final String age;
  final void Function(String) setCurStep;
  final void Function(String) setCurChild;
  final void Function(String) setCurAge;
  final void Function(String) setCurTemperament;
  final void Function(Widget) setCommentBody;

  @override
  State<ButtonWrapper> createState() => _ButtonWrapperState();
}

class _ButtonWrapperState extends State<ButtonWrapper> {
  bool? isChildSame = null;
  void setIsChildSame(bool state) {
    setState(() {
      isChildSame = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChattingRow(
        "user",
        UserWrapper(Container(
            child: Row(children: [
          Container(
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(
                        style: BorderStyle.none,
                      )),
                  onPressed: () {
                    if (isChildSame != null) return;
                    setIsChildSame(true);
                    widget.setCurStep("problemCheck");
                    widget.setCurChild(widget.child);
                    widget.setCurAge(widget.age.toString());
                    widget.setCurTemperament(widget.temperament);
                    widget.setCommentBody(
                        StateWrapper(content: BotProblemCheck(), state: true));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isChildSame == true
                            ? Color(0xffFFA8A6)
                            : Colors.white,
                      ),
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 15,
                        left: 15,
                      ),
                      child: Text("Yes",
                          style: TextStyle(
                              color: isChildSame == true
                                  ? Colors.white
                                  : Color(0xff72777A)))))),
          SizedBox(width: 10),
          Container(
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(
                        style: BorderStyle.none,
                      )),
                  onPressed: () async {
                    if (isChildSame != null) return;
                    setIsChildSame(false);
                    widget.setCurStep("nameCheck");
                    widget.setCommentBody(
                        StateWrapper(content: BotNameCheck(), state: true));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isChildSame == false
                              ? Color(0xffFFA8A6)
                              : Colors.white),
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 15,
                        left: 15,
                      ),
                      child: Text("No",
                          style: TextStyle(
                              color: isChildSame == false
                                  ? Colors.white
                                  : Color(0xff72777A))))))
        ]))));
  }
}

Container BotFirst(String child) {
  return BotWrapper(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Hello. I'm A-eye", style: TextStyle(fontSize: 15, height: 1.5)),
        Text("I'm your personal assistant",
            style: TextStyle(fontSize: 15, height: 1.5)),
        Text("Are you having problem with",
            style: TextStyle(fontSize: 15, height: 1.5)),
        Text("`$child`?", style: TextStyle(fontSize: 15, height: 1.5))
      ]));
}

Container BotNameCheck() {
  return ChattingRow(
      "bot",
      BotWrapper(Column(children: [
        Text("What is his/her name?",
            style: TextStyle(fontSize: 15, height: 1.5))
      ])));
}

Container BotAgeCheck(String child) {
  return ChattingRow(
      "bot",
      BotWrapper(Column(children: [
        Text("How old is $child", style: TextStyle(fontSize: 15, height: 1.5))
      ])));
}

Container BotTemperamentCheck(String child) {
  return ChattingRow(
      "bot",
      BotWrapper(
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("What temperament does",
            style: TextStyle(fontSize: 15, height: 1.5)),
        Text("$child have?", style: TextStyle(fontSize: 15, height: 1.5))
      ])));
}

Container BotProblemCheck() {
  return ChattingRow(
      "bot",
      BotWrapper(Column(children: [
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: Text("Tell me about the problem briefly",
              style: TextStyle(fontSize: 15, height: 1.5)),
        )
      ])));
}

Container BotHmm() {
  return ChattingRow(
      "bot",
      BotWrapper(Column(children: [
        Text("Hmm.. Let me see", style: TextStyle(fontSize: 15, height: 1.5))
      ])));
}

Container ChattingRow(String user, Widget content) {
  if (user == "bot") {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: AeyeIcon(Color(0xffFFF2CB))),
              SizedBox(width: 15),
              Container(child: content)
            ]));
  } else {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [content]));
  }
}

Container AeyeIcon(Color backgroundColor) {
  return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(30)),
      child: Image.asset(
        "assets/images/logo_bard.png",
      ));
}

Container BotWrapper(Widget content) {
  return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 24),
      decoration: BoxDecoration(
        color: Color(0xffFFF2CB),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: content);
}

Container UserWrapper(Widget content) {
  return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffFFF1EC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: content);
}
