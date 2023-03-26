import 'package:flutter/material.dart';

import "../component/baby_monitor/alert.dart";

class BabyMonitor extends StatelessWidget {
  const BabyMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final LocalNotificationController localNotificationController = Get.find();

    // log(localNotificationController.messaging.toString());

    return Scaffold(body: Alert());
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
    return AlertWrapper(
      isAlert: isAlert,
      setIsAlert: setIsAlert,
    );
  }
}
