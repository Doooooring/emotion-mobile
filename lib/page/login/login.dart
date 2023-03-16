import 'package:aeye/page/login/signIn.dart';
import 'package:aeye/page/login/signUp.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xffFFF7DF),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 300,
                height: 300,
                child: Image.asset("assets/images/logo.png")),
            SizedBox(height: 20),
            SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Get.to(() => SignIn());
                    },
                    child: SizedBox(child: Text("Sign In"))),
                SizedBox(width: 30),
                OutlinedButton(
                    onPressed: () {
                      Get.to(() => SignUp());
                    },
                    child: SizedBox(child: Text("Sign Up")))
              ],
            )),
          ]),
    ));
  }
}
