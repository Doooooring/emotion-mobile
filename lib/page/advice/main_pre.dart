import "package:aeye/component/common/app_bar.dart";
import "package:aeye/component/common/bottom_bar.dart";
import "package:aeye/controller/sizeController.dart";
import "package:aeye/page/advice/pop_up_select.dart";
import "package:aeye/page/advice/temperament_explain.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MainPre extends StatelessWidget {
  const MainPre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(null),
      body: Container(
          child: Column(children: [
        SizedBox(
            child: Column(
                children: [Text("What's your baby's"), Text("temperament?")])),
        SizedBox(height: 20),
        SizedBox(
            child: Column(children: [
          NavigatorButton(scaleWidth(context, 200), "What is temperament?",
              PopUpSelect(), Color(0xffE2E2E2)),
          NavigatorButton(scaleWidth(context, 200), "Add Temperament info",
              TemperamentExplain(), Color(0xffFFF7DF))
        ]))
      ])),
      bottomNavigationBar: BottomNavBar(state: true),
    );
  }
}

SizedBox NavigatorButton(
    double width, String title, Widget nextPage, Color color) {
  return SizedBox(
    width: width,
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: color,
            side: BorderSide(
              style: BorderStyle.none,
            )),
        onPressed: () {
          Get.to(() => nextPage);
        },
        child: Text(title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))),
  );
}
