import "package:aeye/controller/routeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(),
          decoration: BoxDecoration(
            color: Color(0xffFFF7DF),
          ),
          child: Column(children: [
            SizedBox(child: Text("I am a...")),
            SizedBox(),
            SizedBox(
                child: Row(children: [
              OutlinedButton(
                  onPressed: () {},
                  child: SizedBox(
                      child: Column(
                          children: [Text("Primary"), Text("Caregiver")]))),
              OutlinedButton(
                  onPressed: () {},
                  child: SizedBox(
                      child: Column(
                          children: [Text("Secondary"), Text("Caregiver")])))
            ])),
            SizedBox(
                child: Column(children: [
              Text("*One who has primary responsibility for taking"),
              Text("care of a child is a primary caregiver")
            ]))
          ])),
    );
  }
}
