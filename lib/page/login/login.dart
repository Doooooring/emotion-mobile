import 'package:aeye/page/login/signIn.dart';
import 'package:aeye/page/login/signUp.dart';
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? userInfo = null;
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FlutterSecureStorage storage = FlutterSecureStorage();

  _asyncMethod() async {
    userInfo = await storage.read(key: "access");
    if (userInfo != null) {
      // Get.to(InitialPage());
    } else {}
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 40, right: 40),
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: Image.asset("assets/images/logo.png")),
                Container(
                    child: Image.asset(
                        width: 230, "assets/images/logo_title.png")),
                SizedBox(height: 50),
                SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                          onPressed: () {
                            Get.to(() => SignIn());
                          },
                          child: Container(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)))),
                    ),
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
                          onPressed: () {
                            Get.to(() => SignUp());
                          },
                          child: Container(
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)))),
                    )
                  ],
                )),
              ]),
        ));
  }
}
