import 'package:flutter/material.dart';

import "../component/common/bottom_bar.dart";
import "../component/common/loading.dart";

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffFAE297),
          elevation: 1.0,
          title: const Text("ah",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
              ))),
      body:
          Container(height: 700, child: Loading(isLoading: false, height: 100)),
      bottomNavigationBar: BottomNavBar(state: true),
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
