import "package:aeye/controller/routeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class PrimarySignUp extends StatelessWidget {
  const PrimarySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();
    return Scaffold(
      body: SizedBox(
          child: Column(children: [
        Container(
            child: Column(children: [
          Text("Pass this verification code"),
          Text("to secondary caregiver")
        ])),
        SizedBox(),
        SizedBox(child: Row(children: [TextField()]))
      ])),
    );
  }
}
