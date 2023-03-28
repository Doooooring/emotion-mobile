import "package:aeye/component/common/loading_proto.dart";
import 'package:aeye/controller/loginController.dart';
import "package:aeye/controller/sizeController.dart";
import "package:aeye/controller/userController.dart";
import "package:aeye/page/initial.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passWordVisible = true;
  void setPassWordVisible() {
    setState(() {
      passWordVisible = !passWordVisible;
    });
  }

  bool isLoading = false;
  void setIsLoading(bool state) {
    isLoading = state;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final UserController userController = Get.find();

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
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
                    SizedBox(height: 25),
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
                                  child: Text("Email",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ))),
                                width: double.infinity,
                                child: TextField(
                                  controller: idController,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 20),
                                      hintText: "Write your email",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(50, 50, 50, 0.4)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, color: Colors.white),
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))),
                              SizedBox(height: scaleHeight(context, 10)),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: passwordController,
                                          obscureText: passWordVisible,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 20),
                                              hintText: "Write your password",
                                              labelStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 50, 0.4)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      color: Colors.white))),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setPassWordVisible();
                                          },
                                          icon: Image.asset(
                                              "assets/images/eye.png"))
                                    ],
                                  )),
                            ],
                          )
                        ])),
                    SizedBox(height: 30),
                    Container(
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
                            Map<String, String?> tokens =
                                await loginController.signIn(
                                    idController.text, passwordController.text);
                            if (tokens["access"] != null) {
                              String accessToken = tokens["access"]!;
                              userController.getAccess(accessToken);
                              Get.to(() => InitialPage());
                            } else {
                              print("fail");
                              return;
                            }
                          },
                          child: Container(
                              child: Text("Sign in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)))),
                    ),
                  ],
                ),
              ),
              Loading(
                  isLoading: isLoading,
                  height: MediaQuery.of(context).size.height)
            ],
          ),
        ),
      ),
    );
  }
}
