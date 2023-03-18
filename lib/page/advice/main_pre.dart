import "package:aeye/component/common/app_bar.dart";
import "package:aeye/component/common/bottom_bar.dart";
import "package:aeye/controller/childController.dart";
import "package:aeye/controller/sizeController.dart";
import "package:aeye/page/advice/main.dart";
import "package:aeye/page/advice/pop_up_select.dart";
import "package:aeye/page/advice/temperament_detail.dart";
import "package:aeye/utils/interface/child.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MainPre extends StatefulWidget {
  const MainPre({Key? key}) : super(key: key);

  @override
  State<MainPre> createState() => _MainPreState();
}

class _MainPreState extends State<MainPre> {
  ChildController childController = Get.find<ChildController>();

  _asyncMethod() async {
    List<Child> tt = [
      {"name": "Alex", "temperament": "Easy"},
      {"name": "Mark", "temperament": "Difficult"},
      {"name": "Minseo", "temperament": "Slow to warm up"}
    ].map((child) {
      return Child.fromJson(child);
    }).toList();
    childController.setChildList(tt);
    Get.back();
    Get.to(() => AdviceMain());

    // get child list from server
    // List<Child> childList = await
    // if (childList.length != 0){
    //   childController.setChildList(childList);
    // }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

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
              TemperamentDetail(), Color(0xffE2E2E2)),
          NavigatorButton(scaleWidth(context, 200), "Add Temperament info",
              PopUpSelect(), Color(0xffFFF7DF))
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
