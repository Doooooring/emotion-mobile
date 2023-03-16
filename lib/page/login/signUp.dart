import "package:aeye/controller/loginController.dart";
import "package:aeye/controller/routeController.dart";
import "package:aeye/controller/sizeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteController routeController = Get.find();
    final LoginController loginController = Get.find();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
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
          padding: EdgeInsets.only(left: 80, right: 30),
          color: Color(0xffFFF7DF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaleHeight(context, 200)),
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
                                Text("Name", style: TextStyle(fontSize: 20))),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          width: scaleWidth(context, 240),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: "Write your name",
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
                            child: Text("id", style: TextStyle(fontSize: 20))),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          width: scaleWidth(context, 240),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Write your id",
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
                            child: Text("password",
                                style: TextStyle(fontSize: 20))),
                        SizedBox(height: scaleHeight(context, 10)),
                        Container(
                            color: Colors.white,
                            width: scaleWidth(context, 240),
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
              SizedBox(
                  child: TextButton(
                      onPressed: () async {
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
                      },
                      child: Text("sign up")))
            ],
          ),
        ),
      ),
    );
  }
}
