import 'package:aeye/controller/loginController.dart';
import "package:aeye/controller/sizeController.dart";
import "package:aeye/controller/userController.dart";
import "package:aeye/page/initial.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final UserController userController = Get.find();

    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(left: 30, right: 30),
          color: Color(0xffFFF7DF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaleHeight(context, 80)),
              IconButton(
                  padding: EdgeInsets.zero, // 패딩 설정
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              SizedBox(height: 15),
              SizedBox(
                  child: Text("Sign in with your email",
                      style: TextStyle(fontSize: 25))),
              SizedBox(height: scaleHeight(context, 40)),
              Container(
                  padding: EdgeInsets.only(),
                  decoration: BoxDecoration(
                    color: Color(0xffFFF7DF),
                  ),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: scaleWidth(context, 120),
                            child:
                                Text("Email", style: TextStyle(fontSize: 20))),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: TextField(
                            controller: idController,
                            decoration: InputDecoration(
                                hintText: "Write your email",
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(50, 50, 50, 0.4)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: scaleWidth(context, 120),
                            child: Text("Password",
                                style: TextStyle(fontSize: 20))),
                        SizedBox(height: scaleHeight(context, 10)),
                        Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: "Write your password",
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(50, 50, 50, 0.4)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, color: Colors.white))),
                            )),
                      ],
                    )
                  ])),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFF717F),
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton(
                      onPressed: () async {
                        Map<String, String?> tokens = await loginController
                            .signIn(idController.text, passwordController.text);
                        if (tokens["access"] != null) {
                          String accessToken = tokens["access"]!;
                          userController.getAccess(accessToken);
                          Get.to(() => InitialPage());
                        } else {
                          print("fail");
                          return;
                        }
                      },
                      child: Text("sign in")))
            ],
          ),
        ),
      ),
    );
  }
}
