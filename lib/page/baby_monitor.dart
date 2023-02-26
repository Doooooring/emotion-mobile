import 'package:flutter/material.dart';
import "package:get/get.dart";

import "../component/baby_monitor/alert.dart";
import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../controller/routeController.dart";

class BabyMonitor extends StatelessWidget {
  const BabyMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();

    return Scaffold(
      appBar: Header(null),
      body: Wrap(children: [
        Container(child: Stack(children: [SizedBox(), Alert()]))
      ]),
      bottomNavigationBar: BottomNavBar(state: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
            backgroundColor: Color(0xffFAE297),
            shape: const CircleBorder(),
            onPressed: () {
              routeController.toInit();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.house,
              size: 35,
              color: Colors.white,
            )),
      ),
    );
  }
}

class Alert extends StatefulWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool isAlert = false;
  void setIsAlert(bool state) {
    setState(() {
      isAlert = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AlertWrapper(
      isAlert: isAlert,
      setIsAlert: setIsAlert,
    ));
  }
}
