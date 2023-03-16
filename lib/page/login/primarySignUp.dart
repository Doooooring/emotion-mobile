import "package:aeye/controller/routeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class PrimarySignUp extends StatelessWidget {
  const PrimarySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("here");
    final RouteController routeController = Get.find();
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xffFFF7DF),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text("Pass this verification code"),
                      Text("to secondary caregiver")
                    ])),
                SizedBox(height: 10),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(width: 200, height: 50, child: TextField())
                    ])),
                SizedBox(
                    child: TextButton(onPressed: () {}, child: Text("submit")))
              ])),
    );
  }
}
