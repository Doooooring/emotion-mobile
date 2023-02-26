import 'package:flutter/material.dart';

import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../component/common/loading_proto.dart";

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(null),
      body: Column(
        children: [
          Container(height: 400, child: Loading(isLoading: true, height: 100)),
        ],
      ),
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
