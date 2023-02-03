import 'package:flutter/material.dart';

import "../component/common/bottom_bar.dart";

class BabyMonitor extends StatelessWidget {
  const BabyMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
            backgroundColor: Color(0xffFAE297),
            shape: const CircleBorder(),
            onPressed: () {},
            child: Icon(
              Icons.house,
              size: 35,
              color: Colors.black,
            )),
      ),
    );
  }
}
