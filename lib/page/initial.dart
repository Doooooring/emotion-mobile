import "dart:convert";
import "dart:developer";

import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;

import "../asset/url.dart";
import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../component/common/loading_proto.dart";

class InitialPage extends StatelessWidget {
  final bool isAlert = Get.find();

  InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(null),
      body: Column(
        children: [
          Container(height: 400, child: Loading(isLoading: true, height: 100)),
          IconButton(
              onPressed: () async {
                Uri endPoint =
                    Uri.parse('$HOST_URL/oauth2/authorization/google');
                http.Response response = await http.get(endPoint,
                    headers: {"Content-Type": "application/json"});
                dynamic result = json.decode(utf8.decode(response.bodyBytes));
                log(result["result"].toString());
              },
              icon: Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: BottomNavBar(state: true),
    );
  }
}
