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
        body: Container(
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
                                  fontSize: 30, fontWeight: FontWeight.w400)),
                          Text("temperament?",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w400))
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
                            style: TextStyle(fontSize: 18))
                      ])),
              SizedBox(height: 30),
              Text("Types of Temperaments",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
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
