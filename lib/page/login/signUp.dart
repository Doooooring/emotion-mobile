import "package:aeye/component/common/loading_proto.dart";
import "package:aeye/controller/loginController.dart";
import "package:aeye/controller/sizeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool passwordView = true;
  void setPasswordVisible() {
    setState(() {
      passwordView = !passwordView;
    });
  }

  bool passWordConfirmView = true;
  void setPasswordConfirmVisible() {
    setState(() {
      passwordView = !passwordView;
    });
  }

  bool isLoading = false;
  void setIsLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    return isLoading
        ? Loading(
            isLoading: isLoading, height: MediaQuery.of(context).size.height)
        : Scaffold(
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
                          SizedBox(height: 15),
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
                                        child: Text("Name",
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
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.only(bottom: 20),
                                            hintText: "Enter your name",
                                            labelStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 50, 0.4)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.white))),
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
                                        child: Text("Email",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700))),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ))),
                                      child: TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.only(bottom: 20),
                                            hintText: "Enter your email",
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
                                                obscureText: passwordView,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 20),
                                                    hintText:
                                                        "Your password, at least 8 character",
                                                    labelStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 50, 0.4)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color: Colors.white),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0,
                                                                color: Colors
                                                                    .white))),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  if (passwordController
                                                          .text.length <
                                                      8) {
                                                    return;
                                                  }
                                                  if (passwordController.text !=
                                                      passwordConfirmController
                                                          .text) {
                                                    return;
                                                  }
                                                  setPasswordVisible();
                                                },
                                                icon: Image.asset(
                                                    "assets/images/eye.png"))
                                          ],
                                        )),
                                    SizedBox(height: 30),
                                    SizedBox(
                                        width: scaleWidth(context, 250),
                                        child: Text("Confirm Password",
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
                                                controller:
                                                    passwordConfirmController,
                                                obscureText:
                                                    passWordConfirmView,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 20),
                                                    hintText:
                                                        "Re-type your password",
                                                    labelStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 50, 0.4)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color: Colors.white),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0,
                                                                color: Colors
                                                                    .white))),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setPasswordConfirmVisible();
                                                },
                                                icon: Image.asset(
                                                    "assets/images/eye.png"))
                                          ],
                                        )),
                                  ],
                                )
                              ])),
                          SizedBox(height: 20),
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
                                  setIsLoading(true);
                                  bool result = await loginController.signUp(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);
                                  if (result) {
                                    print(result);
                                    Get.back();
                                  } else {
                                    print("fail");
                                  }
                                  setIsLoading(false);
                                },
                                child: Container(
                                    child: Text("Sign up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
