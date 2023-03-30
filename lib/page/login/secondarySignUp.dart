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
                      Text("Did you get verification code",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400)),
                      SizedBox(height: 10),
                      Text("from primary caregiver?",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400))
                    ])),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(0, 0))
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              width: MediaQuery.of(context).size.width - 200,
                              padding: EdgeInsets.only(left: 30, right: 30),
                              height: 60,
                              child: TextField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.white))),
                                  controller: textEditingController))
                        ])),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 133, 127, 0.70),
                        borderRadius: BorderRadius.circular(35)),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                          style: BorderStyle.none,
                        )),
                        onPressed: () async {
                          Get.back();
                          return;
                          Map<String, String> response = await loginController
                              .chooseRole("sub", textEditingController.text);
                          String status = response["code"]!;
                          if (status == "good") {
                            Get.to(() => InitialPage());
                          }
                        },
                        child: Container(
                            child: Text("submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)))),
                  ),
                ),
              ])),
    );
  }
}
