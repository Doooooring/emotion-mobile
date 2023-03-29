import "package:aeye/controller/loginController.dart";
import 'package:aeye/page/initial.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

class SecondarySignUp extends StatelessWidget {
  const SecondarySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = LoginController();
    TextEditingController textEditingController = TextEditingController();

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
                      Text("Did you get verification code"),
                      Text("from primary caregiver")
                    ])),
                SizedBox(height: 10),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(
                          width: 200,
                          height: 50,
                          child: TextField(controller: textEditingController))
                    ])),
                SizedBox(
                    child: TextButton(
                        onPressed: () async {
                          Map<String, String> response = await loginController
                              .chooseRole("sub", textEditingController.text);
                          String status = response["code"]!;
                          if (status == "good") {
                            Get.to(() => InitialPage());
                          }
                        },
                        child: Text("submit")))
              ])),
    );
  }
}
