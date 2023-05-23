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

  bool? isChildSame = null;
  void setIsChildSame(bool state) {
    setState(() {
      isChildSame = state;
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
      setCommentBody(ChattingRow("bot", BotAgeCheck(input)));
    } else if (curStep == "ageCheck") {
      setCurAge(input);
      setCurStep("temperamentCheck");
      setCommentBody(ChattingRow("user", UserWrapper(Text(input))));
      setCommentBody(ChattingRow("bot", BotTemperamentCheck(curChild)));
      setCommentBody(ChattingRow(
          "user",
          TemperamentButtonWrapper(
            setCommentBody: setCommentBody,
            setCurStep: setCurStep,
            setCurTemperament: setCurTemperament,
          )));
    } else if (curStep == "problemCheck") {
      setCurProblem(input);
      setCurStep("problemCheck");
      setCommentBody(ChattingRow("user", UserWrapper(Text(input))));
      setCommentBody(ChattingRow("bot", BotHmm()));
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
      setCommentBody(StateWrapper(
          content: ChattingRow("bot", BotFirst(widget.child)), state: true));
      setCommentBody(StateWrapper(
          content: ChattingRow(
              "user",
              Container(
                  child: Row(children: [
                Container(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                          style: BorderStyle.none,
                        )),
                        onPressed: () async {
                          setIsChildSame(true);
                          setCurStep("problemCheck");
                          setCurChild(widget.child);
                          setCurAge(widget.age.toString());
                          setCurTemperament(widget.temperament);
                          setCommentBody(StateWrapper(
                              content: ChattingRow("bot", BotProblemCheck()),
                              state: true));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color(0xffFF717F),
                            padding: EdgeInsets.all(5),
                            child: Text("Yes")))),
                Container(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                          style: BorderStyle.none,
                        )),
                        onPressed: () async {
                          setIsChildSame(false);
                          setCurStep("nameCheck");
                          setCommentBody(StateWrapper(
                              content: BotNameCheck(), state: true));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color(0xffFF717F),
                            padding: EdgeInsets.all(5),
                            child: Text("No"))))
              ]))),
          state: true));
    }

    return Scaffold(
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
                AeyeIcon(),
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
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [])));
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
    return SizedBox(
        width: double.infinity,
        child: Row(children: [
          Container(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    style: BorderStyle.none,
                  )),
                  onPressed: () async {
                    setCurCheck("Easy");
                    widget.setCurTemperament("Easy");
                    widget.setCommentBody(ChattingRow(
                        "bot",
                        BotWrapper(
                            Text("Tell me about the problem briefly."))));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xffFF717F),
                      padding: EdgeInsets.all(5),
                      child: Text("easy")))),
          Container(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    style: BorderStyle.none,
                  )),
                  onPressed: () async {
                    setCurCheck("Difficult");
                    widget.setCurTemperament("Difficult");
                    widget.setCommentBody(ChattingRow("user",
                        BotWrapper(Text("Tell me about the problem briefly"))));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xffFF717F),
                      padding: EdgeInsets.all(5),
                      child: Text("difficult")))),
          Container(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    style: BorderStyle.none,
                  )),
                  onPressed: () async {
                    setCurCheck("Slow-to-warm-up");
                    widget.setCurTemperament("Slow-to-warm-up");
                    widget.setCommentBody(ChattingRow("user",
                        BotWrapper(Text("Tell me about the problem briefly"))));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xffFF717F),
                      padding: EdgeInsets.all(5),
                      child: Text("slow-to-warm-up"))))
        ]));
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
          ProgressIndicatorWrapper(isLoading: isLoading),
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
                              ),
                              color: Color(0xffFFDD67),
                              padding: EdgeInsets.all(5),
                              child: Text("View  solutions",
                                  style: TextStyle(color: Colors.white)))),
                    ],
                  ),
                )
        ])));
  }
}

Container BotFirst(String child) {
  return BotWrapper(Column(children: [
    Row(children: [
      Text("Hello. I'm A-eye"),
      Text("I'm your personal assistant")
    ]),
    Text("I'm your personal assistant"),
    Text("Are you having problem with '$child'")
  ]));
}

Container BotNameCheck() {
  return BotWrapper(Column(children: [Text("What is his/her name?")]));
}

Container BotAgeCheck(String child) {
  return BotWrapper(Column(children: [Text("How old is $child")]));
}

Container BotTemperamentCheck(String child) {
  return BotWrapper(
      Column(children: [Text("What temperament does $child have?")]));
}

Container BotProblemCheck() {
  return BotWrapper(
      Column(children: [Text("Tell me about the problem briefly")]));
}

Container BotHmm() {
  return BotWrapper(Column(children: [Text("Hmm.. Let me see")]));
}

Container ChattingRow(String user, Widget content) {
  if (user == "bot") {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(child: AeyeIcon()),
          Container(child: content)
        ]));
  } else {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [content]));
  }
}

Container AeyeIcon() {
  return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Image.asset("assets/images/logo.png"));
}

Container BotWrapper(Widget content) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Color(0xffFFF7DF)),
      child: content);
}

Container UserWrapper(Widget content) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Color(0xffFFF1EC)),
      child: content);
}
