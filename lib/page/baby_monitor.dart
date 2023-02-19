import 'package:flutter/material.dart';

import "../component/baby_monitor/alert.dart";
import "../component/common/bottom_bar.dart";

class BabyMonitor extends StatelessWidget {
  const BabyMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffFAE297),
          elevation: 1.0,
          title: const Text("hmm",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
              ))),
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
            onPressed: () {},
            child: Icon(
              Icons.house,
              size: 35,
              color: Colors.black,
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
