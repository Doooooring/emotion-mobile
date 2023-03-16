import "package:aeye/controller/routeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SecondarySignUp extends StatelessWidget {
  const SecondarySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();
    return Scaffold(
      body: SizedBox(
          child: Column(children: [
        Container(
            child: Column(children: [
          Text("Did you get verification code"),
          Text("from primary caregiver")
        ])),
        SizedBox(),
        SizedBox(child: Row(children: [TextField()]))
      ])),
    );
  }
}
