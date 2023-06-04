import 'package:aeye/page/advice/main.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

class Explain {
  Explain(this.characteristics, this.raising, this.example);
  final List<String> characteristics;
  final List<String> raising;
  final String example;
}

Explain easyExplain = Explain([
  "regular bodily functions",
  "a positive approach to new situations",
  "adaptability",
  "a positive mood",
  "a non-intense reaction to stimuli"
], [
  "Raising these children is relatively easy because they respond favorably to various child-raising practices. They readily adapt to different parental handling."
], "During a birthday party, an easy child will join in the party games easily without any fuss. They will also be able to switch from activity to activity without difficulty.");

Explain difficultExplain = Explain([
  "irregular bodily functions",
  "withdrawal from new situations",
  "slow adaptability",
  "negative mood",
  "intense reaction"
], [
  'Some difficult babies are also highly sensitive babies. Raising these children is difficult from the get-go. But this is by no means the definition of being “difficult”.',
  'Difficult babies with an intense and highly reactive temperament tend to be crying a lot. They cry hard, they cry loudly and they are hard to soothe.',
  'They are also cranky babies. They tend to have sleep problems. They have a hard time falling and staying asleep. When they wake up in the middle of the night, they have trouble going back to sleep.'
], "It may be hard for them to wait patiently for their turn. When switching from playing games to going into the party room, they may have a tantrum because they are in the middle of a game.");

Explain slowExplain = Explain([
  "low activity level and low intensity of reaction although they also have a tendency to withdraw from new situations",
  "slow adaptability",
  "somewhat negative mood"
], [
  "A slow-to-warm-up child is a cautious child. These kids can adapt to new situations if they’re allowed to do that at their own pace. However, if pressured to do so, these children may fall back to their natural tendency to withdraw."
], "When a slow-to-warm-up child first arrives at the party, they may trail behind their parents and not join the other kids. After watching other kids play for twenty minutes, they cautiously join in and have fun.");

Map<String, Explain> explainMap = {
  "Easy": easyExplain,
  "Difficult": difficultExplain,
  "Slow to warm up": slowExplain
};

class TemperamentResult extends StatefulWidget {
  const TemperamentResult(
      {Key? key, required this.child, required this.temperament})
      : super(key: key);

  final String child;
  final String temperament;

  @override
  State<TemperamentResult> createState() => _TemperamentResultState();
}

class _TemperamentResultState extends State<TemperamentResult> {
  @override
  Widget build(BuildContext context) {
    String imageLink = "";

    switch (widget.temperament) {
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

    Explain curExplain = explainMap[widget.temperament]!;

    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
                color: Color(0xffFFF2CB),
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 120),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                            onPressed: () {
                              Get.to(AdviceMain());
                            },
                            child: Text("Done",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)))
                      ]),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.child}'s temperament",
                              style: TextStyle(
                                  fontSize: 25, color: Color(0xffED5564)))
                        ],
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Image.asset(imageLink)])),
                      SizedBox(height: 28),
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [TemperHeader(widget.temperament)])),
                      SizedBox(height: 28),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    child: Text("Characteristics",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Color(0xffFF717F)))),
                                SizedBox(height: 10),
                                SizedBox(
                                    child: Column(
                                        children: curExplain.characteristics
                                            .map((characteristic) {
                                  return SizedBox(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        SizedBox(width: 10),
                                        SizedBox(
                                            child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Icon(Icons.circle, size: 8),
                                          ],
                                        )),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(characteristic,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ]));
                                }).toList())),
                              ])),
                      SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    child: Text("Raising",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Color(0xffFF717F)))),
                                SizedBox(height: 10),
                                SizedBox(
                                    child: Column(
                                        children:
                                            curExplain.raising.map((comp) {
                                  return SizedBox(
                                      child: Column(children: [
                                    Text(comp,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 20)
                                  ]));
                                }).toList())),
                              ])),
                      SizedBox(height: 30),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Example",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xffFF717F))),
                                SizedBox(height: 10),
                                Text(curExplain.example,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))
                              ]))
                    ]))));
  }
}

SizedBox TemperHeader(String temperament) {
  if (temperament == "Slow to warm up") {
    return SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text("Slow to warm up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Text("temperament",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
        ]));
  }
  return SizedBox(
      child: Row(children: [
    Text(temperament,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
    Text(" temperament",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
  ]));
}
