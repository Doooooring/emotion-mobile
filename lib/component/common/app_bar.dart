import "package:firstproject/controller/routeController.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

AppBar Header() {
  final RouteController routeController = Get.find();

  return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            if (routeController.curPath != "init") {
              routeController.toInit();
              Navigator.pop(context);
              return;
            } else {
              return;
            }
          },
        );
      }),
      backgroundColor: Color(0xffFAE297),
      elevation: 1.0,
      title: const Text("hmm",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 30,
          )));
}
