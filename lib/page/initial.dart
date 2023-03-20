import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../controller/sizeController.dart";
import 'login/login.dart';

final dio = Dio();

Map Month = {
  "1": "Jan",
  "2": "Feb",
  "3": "Mar",
  "4": "Apr",
  "5": "May",
  "6": "Jun",
  "7": "Jul",
  "8": "Aug",
  "9": "Sep",
  "10": "Oct",
  "11": "Nov",
  "12": "Dec"
};

class InitialPage extends StatelessWidget {
  final bool isAlert = Get.find();

  InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int month = today.month;
    int day = today.day;
    int hour = today.hour;

    print("hour");
    print(hour);

    String monthToStr = Month[month.toString()];

    return Scaffold(
      appBar: Header(null, "init"),
      body: Column(children: [
        Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 18.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 6))
                ],
                color: Color(0xffFFF7DF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            padding: EdgeInsets.only(
                left: scaleWidth(context, 40),
                right: scaleWidth(context, 40),
                top: scaleHeight(context, 50),
                bottom: scaleHeight(context, 50)),
            child: Row(children: [
              Container(
                  width: scaleWidth(context, 90),
                  height: scaleWidth(context, 90),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 133, 127, 0.44),
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(monthToStr,
                            style: TextStyle(
                              fontSize: 30,
                            )),
                        SizedBox(height: 1),
                        Text(day.toString(),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700))
                      ]))
            ])),
        IconButton(
            onPressed: () {
              Get.to(Login());
            },
            icon: Icon(Icons.ac_unit))
      ]),
      bottomNavigationBar: BottomNavBar(state: true, curPath: "init"),
    );
  }
}
