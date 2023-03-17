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
                left: scaleWidth(context, 30),
                right: scaleWidth(context, 30),
                top: scaleHeight(context, 30)),
            child: Column(children: [
              SizedBox(
                  width: double.infinity,
                  child: Row(children: [
                    ButtonBack(),
                    SizedBox(
                        child: Column(
                            children: [Text("What is"), Text("temperament")])),
                    ButtonBack()
                  ])),
              SizedBox(height: 20),
              Container(
                  child: Column(children: [
                Text("Temperament"),
                SizedBox(height: 10),
                Text(
                    "is a person's own unique characteristic that he or she has since birth")
              ])),
              SizedBox(height: 20),
              Text("Types of Temperaments"),
              SizedBox(
                  child: Column(children: [
                NavigatorButton("Easy", context),
                NavigatorButton("Difficult", context),
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
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              backgroundColor: Colors.white,
              side: BorderSide(
                style: BorderStyle.none,
              )),
          onPressed: () {
            () => Get.to(TemperamentExplain(temperament: temperament));
          },
          child: SizedBox(
              child: Row(children: [
            Image.asset(imageLink),
            SizedBox(width: 10),
            Text(temperament),
            SizedBox(width: 10),
            Text("temperament")
          ]))));
}
