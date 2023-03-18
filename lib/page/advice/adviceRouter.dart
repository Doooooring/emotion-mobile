import "package:aeye/controller/childController.dart";
import "package:aeye/page/advice/main_pre.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AdviceRouter extends StatefulWidget {
  const AdviceRouter({Key? key}) : super(key: key);

  @override
  State<AdviceRouter> createState() => _AdviceRouterState();
}

class _AdviceRouterState extends State<AdviceRouter> {
  ChildController childController = Get.find<ChildController>();
  @override
  Widget build(BuildContext context) {
    return MainPre();
  }
}
