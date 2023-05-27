import "package:aeye/controller/loginController.dart";
import 'package:aeye/controller/userController.dart';
import "package:aeye/page/initial.dart";
import 'package:aeye/page/login/secondarySignUp.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

class ChooseRole extends StatelessWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    UserController userController = Get.find();

    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(),
          decoration: BoxDecoration(
            color: Color(0xffFFF2CB),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    child: Text("I am a...",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500))),
                SizedBox(height: 20),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Container(
                        width: 150,
                        height: 120,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            onPressed: () async {
                              print("here");
                              Map<String, String> code = await loginController
                                  .chooseRole("main", null);
                              userController.getCode(code["code"]!);
                              Get.to(() => InitialPage());
                            },
                            child: Container(
                                width: 120,
                                height: 120,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Primary",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      Text("Caregiver",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500))
                                    ]))),
                      ),
                      SizedBox(width: 30),
                      SizedBox(
                        width: 150,
                        height: 120,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  style: BorderStyle.none,
                                )),
                            onPressed: () {
                              print("here");
                              Get.to(() => SecondarySignUp());
                            },
                            child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                  Text("Secondary",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  Text("Caregiver",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))
                                ]))),
                      )
                    ])),
                SizedBox(height: 20),
                SizedBox(
                    child: Column(children: [
                  Text("*One who has primary responsibility for taking",
                      style: TextStyle(fontSize: 18)),
                  Text("care of a child is a primary caregiver",
                      style: TextStyle(fontSize: 18))
                ])),
              ])),
    );
  }
}
