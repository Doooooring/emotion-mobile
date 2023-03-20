import "package:aeye/component/common/app_bar.dart";
import "package:aeye/component/common/bottom_bar.dart";
import "package:aeye/controller/childController.dart";
import "package:aeye/controller/sizeController.dart";
import "package:aeye/page/advice/revise_info.dart";
import "package:aeye/page/advice/temperament_explain.dart";
import "package:aeye/page/advice/tipDetail.dart";
import "package:aeye/utils/interface/child.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AdviceMain extends StatefulWidget {
  const AdviceMain({Key? key}) : super(key: key);

  @override
  State<AdviceMain> createState() => _AdviceMainState();
}

class _AdviceMainState extends State<AdviceMain> {
  ChildController childController = Get.find();

  int curViewInd = 0;
  void setViewToRight() {
    setState(() {
      curViewInd += 1;
    });
  }

  void setViewToLeft() {
    setState(() {
      curViewInd -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> curTips = ["During conflicts", "Changing environment"];

    List<Child> childList = childController.childList!;
    print(childList);
    Child curView = childList[curViewInd];
    String curTemp = curView.temperament;

    return Scaffold(
      appBar: Header(null, "advice"),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(children: [
            Container(
                child: Column(children: [
              ViewTemperament(
                  childList: childList,
                  curViewInd: curViewInd,
                  curView: curView,
                  setViewToLeft: setViewToLeft,
                  setViewToRight: setViewToRight)
            ])),
            SizedBox(height: 80),
            SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text("Parenting tips",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),
                  Column(
                      children: curTips.map((tip) {
                    return TipsNavigator(
                        tip,
                        TipDetail(
                            temperament: curTemp,
                            title: tip,
                            name: curView.name),
                        context);
                  }).toList())
                ]))
          ])),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "advice"),
    );
  }
}

class ViewTemperament extends StatefulWidget {
  const ViewTemperament(
      {Key? key,
      required this.childList,
      required this.curViewInd,
      required this.curView,
      required this.setViewToLeft,
      required this.setViewToRight})
      : super(key: key);

  final List<Child> childList;
  final int curViewInd;
  final Child curView;
  final void Function() setViewToLeft;
  final void Function() setViewToRight;

  @override
  State<ViewTemperament> createState() => _ViewTemperamentState();
}

class _ViewTemperamentState extends State<ViewTemperament> {
  @override
  Widget build(BuildContext context) {
    double distance = MediaQuery.of(context).size.width - 60;
    double height = scaleHeight(context, 200);
    return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xffFFF7DF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 18.0,
                spreadRadius: 0.0,
                offset: Offset(0, 6))
          ],
        ),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            width: double.infinity,
            height: height,
          ),
          Positioned(
            left: -1 * distance * widget.curViewInd,
            child: SizedBox(
                child: Row(
                    children: widget.childList.map((child) {
              return Slide(child, distance, height);
            }).toList())),
          ),
          Positioned(
              top: height / 2 - 15,
              left: 5,
              child: IconButton(
                  padding: EdgeInsets.zero, // 패딩 설정
                  constraints: BoxConstraints(),
                  onPressed: () {
                    if (widget.curViewInd == 0) {
                      return;
                    }
                    widget.setViewToLeft();
                  },
                  icon: widget.curViewInd == 0
                      ? SizedBox(width: 0)
                      : Icon(size: 30, Icons.keyboard_arrow_left))),
          Positioned(
              top: height / 2 - 15,
              right: 5,
              child: IconButton(
                  padding: EdgeInsets.zero, // 패딩 설정
                  constraints: BoxConstraints(),
                  onPressed: () {
                    if (widget.curViewInd + 1 == widget.childList.length) {
                      return;
                    }
                    widget.setViewToRight();
                  },
                  icon: widget.curViewInd + 1 == widget.childList.length
                      ? SizedBox(width: 0)
                      : Icon(size: 30, Icons.keyboard_arrow_right)))
        ]));
  }
}

Container Slide(Child child, double width, double height) {
  return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(left: 50, right: 30, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {
                Get.to(() => ReviseInfo(id: child.id));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Change child's", style: TextStyle(color: Colors.grey)),
                  Text("temperament", style: TextStyle(color: Colors.grey))
                ],
              ))
        ])),
        Text(child.name,
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800)),
        SizedBox(height: 20),
        TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Get.to(() => TemperamentExplain(temperament: child.temperament));
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(child.temperament,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFF717F))),
                    SizedBox(height: 15),
                    Text("temperament",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFF717F)))
                  ]),
            ))
      ]));
}

Container TipsNavigator(String title, Widget navigate, BuildContext context) {
  return Container(
      width: double.infinity,
      height: scaleHeight(context, 45),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(189, 189, 189, 0.5), width: 1.0))),
      child: TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.only(
                top: 15,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.topLeft),
          onPressed: () {
            Get.to(() => navigate);
          },
          child: Text(title,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400))));
}
