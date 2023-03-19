import 'package:flutter/material.dart';

import "../component/baby_monitor/alert.dart";
import "../component/common/app_bar.dart";

class BabyMonitor extends StatelessWidget {
  const BabyMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final LocalNotificationController localNotificationController = Get.find();

    // log(localNotificationController.messaging.toString());

    return Scaffold(
      appBar: Header(null, "babyMonitor"),
      body: Wrap(children: [
        Container(child: Stack(children: [SizedBox(), Alert()]))
      ]),
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
