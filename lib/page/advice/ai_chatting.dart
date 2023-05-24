import "dart:async";

import "package:aeye/component/common/loading_proto.dart";
import "package:flutter/material.dart";

class AiChatting extends StatefulWidget {
  const AiChatting(
      {Key? key,
      required this.child,
      required this.temperament,
      required this.age})
      : super(key: key);

  final String child;
  final String temperament;
  final int age;

  @override
  State<AiChatting> createState() => _AiChattingState();
}

class _AiChattingState extends State<AiChatting> {
  TextEditingController controller = TextEditingController();

  void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  List<Widget> commentBody = [];
  void setCommentBody(Widget comment) {
    setState(() {
      commentBody.add(comment);
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
          backgroundColor: Color(0xffFFF7DF),
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
                          child: Container(
                              height: 1000,
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Column(children: commentBody)))),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 280,
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
                                  controller: controller,
                                  scrollPadding: EdgeInsets.all(0),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: "Add A Comment",
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
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
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
                              removeFocus(context);
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

Row CommentInput(TextEditingController controller) {
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
    OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(
        style: BorderStyle.none,
      )),
      onPressed: () async {},
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color(0xffFF717F),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.send, color: Colors.white),
            ],
          )),
    )
  ]);
}

class ChattingBody extends StatefulWidget {
  const ChattingBody({Key? key}) : super(key: key);

  @override
  State<ChattingBody> createState() => _ChattingBodyState();
}

class _ChattingBodyState extends State<ChattingBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
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
                          BotWrapper(
                              Text("Tell me about the problem briefly."))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Easy"
                              ? Color(0xffFF717F)
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
                          "user",
                          BotWrapper(
                              Text("Tell me about the problem briefly"))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Difficult"
                              ? Color(0xffFF717F)
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
                          "user",
                          BotWrapper(
                              Text("Tell me about the problem briefly"))));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: curCheck == "Slow-to-warm-up"
                              ? Color(0xffFF717F)
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
      required this.name,
      required this.age,
      required this.temperament,
      required this.problem})
      : super(key: key);

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

  List<void> solutions = [];
  void setSolutions(List<void> newSolutions) {
    setState(() {
      solutions = newSolutions;
    });
  }

  _asyncMethod() async {
    setIsLoading(true);
    // api 호출
    Timer(Duration(seconds: 3), () {
      setIsLoading(false);
    });
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
                      Text("Here are solutions"),
                      SizedBox(height: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            style: BorderStyle.none,
                          )),
                          onPressed: () async {},
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffFFDD67),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Text("View  solutions",
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
        Text("Hello. I'm A-eye", style: TextStyle(height: 1.5)),
        Text("I'm your personal assistant", style: TextStyle(height: 1.5)),
        Text("Are you having problem with", style: TextStyle(height: 1.5)),
        Text("`$child`?", style: TextStyle(height: 1.5))
      ]));
}

Container BotNameCheck() {
  return ChattingRow(
      "bot", BotWrapper(Column(children: [Text("What is his/her name?")])));
}

Container BotAgeCheck(String child) {
  return ChattingRow(
      "bot", BotWrapper(Column(children: [Text("How old is $child")])));
}

Container BotTemperamentCheck(String child) {
  return ChattingRow(
      "bot",
      BotWrapper(
          Column(children: [Text("What temperament does $child have?")])));
}

Container BotProblemCheck() {
  return ChattingRow(
      "bot",
      BotWrapper(
          Column(children: [Text("Tell me about the problem briefly")])));
}

Container BotHmm() {
  return ChattingRow(
      "bot", BotWrapper(Column(children: [Text("Hmm.. Let me see")])));
}

Container ChattingRow(String user, Widget content) {
  if (user == "bot") {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: AeyeIcon(Color(0xffFFF7DF))),
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
      padding: EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xffFFF7DF),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: content);
}

Container UserWrapper(Widget content) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffFFF1EC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: content);
}
