import "package:aeye/controller/childController.dart";
import "package:aeye/controller/sizeController.dart";
import 'package:aeye/page/advice/temperament_test.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

// AdviceServices adviceServices = AdviceServices();

class PopUpSelect extends StatefulWidget {
  const PopUpSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<PopUpSelect> createState() => _PopUpSelectState();
}

class _PopUpSelectState extends State<PopUpSelect> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  ChildController childController = Get.find();

  String dropDownValue = "Easy";
  void setDropDownValue(String newValue) {
    setState(() {
      dropDownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PopUp(context, dropDownValue, setDropDownValue, nameController,
            ageController, childController));
  }
}

GestureDetector PopUp(
    BuildContext context,
    String dropDownValue,
    Function(String) setDropDownValue,
    TextEditingController nameController,
    TextEditingController ageController,
    ChildController childController) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      FocusScope.of(context).requestFocus(new FocusNode());
    },
    child: Container(
        color: Color(0xffFAF8F8),
        width: double.infinity,
        padding: EdgeInsets.only(left: 30, right: 30, top: 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                TextButton(
                    onPressed: () {
                      Get.to(TemperamentTest(
                          child: nameController.text,
                          age: int.parse(ageController.text)));
                      // bool apiState = await adviceServices.addChild(
                      //     nameController.text,
                      //     ageController.text,
                      //     childController);
                      // if (apiState) {
                      //   Get.to(AdviceMain());
                      // } else {
                      //   print("post error");
                      // }
                    },
                    child: Text("Save",
                        style: TextStyle(color: Colors.black, fontSize: 22)))
              ])),
          SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add info", style: TextStyle(fontSize: 30))
                  ])),
          SizedBox(height: 100),
          SizedBox(
              width: double.infinity,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: scaleWidth(context, 140),
                        child: Text("Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 23))),
                    SizedBox(width: scaleWidth(context, 10)),
                    Container(
                      width: scaleWidth(context, 150),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset.zero,
                              blurRadius: 1.0,
                              spreadRadius: 0,
                            )
                          ]),
                      child: TextField(
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 15, color: Color.fromRGBO(50, 50, 50, 1)),
                        controller: nameController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Write your child name",
                            hintStyle: TextStyle(fontSize: 15),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(50, 50, 50, 0.4)),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                    )
                  ])),
          SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: scaleWidth(context, 140),
                    child: Text("Age",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 23))),
                SizedBox(width: scaleWidth(context, 10)),
                Container(
                  width: scaleWidth(context, 150),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1.0,
                          spreadRadius: 0,
                        )
                      ]),
                  child: TextField(
                    scrollPadding: EdgeInsets.all(0),
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(50, 50, 50, 1)),
                    controller: ageController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: "Write your child name",
                        hintStyle: TextStyle(fontSize: 15),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white))),
                  ),
                  // child: DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //         labelStyle:
                  //             TextStyle(color: Color.fromRGBO(50, 50, 50, 0.4)),
                  //         contentPadding: EdgeInsets.only(left: 10),
                  //         enabledBorder: InputBorder.none,
                  //         focusedBorder: InputBorder.none,
                  //         border: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white))),
                  //     dropdownColor: Colors.white,
                  //     menuMaxHeight: 200,
                  //     value: dropDownValue,
                  //     items: ["Easy", "Difficult", "Slow to warm up"]
                  //         .map((temperament) {
                  //       return DropdownMenuItem(
                  //           value: temperament,
                  //           child: Container(
                  //               child: Text(
                  //             temperament,
                  //           )));
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       if (value == null) {
                  //         return;
                  //       }
                  //       setDropDownValue(value);
                  //     }),
                )
              ]))
        ])),
  );
}
