import "dart:convert";
import "dart:developer";
import "dart:io";

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import "../component/common/app_bar.dart";
import "../component/common/bottom_bar.dart";
import "../component/common/loading_proto.dart";
import 'login/login.dart';
import 'login/loginGoogle.dart';

final dio = Dio();

Future<Uri> resolveRedirection({required String url}) async {
  Dio dio = new Dio();
  dio.options.followRedirects = true;
  dio.options.responseType = ResponseType.plain;
  dynamic response = await dio.get(url.toString());
  return response.realUri;
}

class InitialPage extends StatelessWidget {
  final bool isAlert = Get.find();

  InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(null),
      body: Column(children: [
        Container(height: 400, child: Loading(isLoading: true, height: 100)),
        IconButton(
            onPressed: () async {
              HttpClient client = HttpClient();
              Uri endPoint = Uri.parse(
                  'http://api.a-eye.co.kr/oauth2/authorization/google');
              try {
                print("here");
                HttpClientRequest request = await client.getUrl(endPoint);
                print(request);
                request.followRedirects = true;
                HttpClientResponse response = await request.close();
                final stringData =
                    await response.transform(utf8.decoder).join();
                print(stringData);
              } catch (e) {
                print(e);
              }
              http.Response response = await http.get(endPoint);
              dynamic result = json.decode(utf8.decode(response.bodyBytes));
              log(result["result"].toString());
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () async {
              Uri endPoint = await resolveRedirection(
                  url: 'http://api.a-eye.co.kr/oauth2/authorization/google');

              bool possible = await launchUrl(
                endPoint,
                mode: LaunchMode.externalApplication,
              );

              http.Response response = await http.get(endPoint);
              dynamic result = json.decode(utf8.decode(response.bodyBytes));
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () async {
              Uri endPoint = await resolveRedirection(
                  url: 'http://api.a-eye.co.kr/oauth2/authorization/google');
              print(endPoint);
              bool possible = await launchUrl(endPoint);
              print(possible);
              http.Response response = await http.get(endPoint);
              dynamic result = json.decode(utf8.decode(response.bodyBytes));
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {
              Get.to(LoginGoogle());
            },
            icon: Icon(Icons.ac_unit)),
        IconButton(
            onPressed: () {
              Get.to(Login());
            },
            icon: Icon(Icons.ac_unit))
      ]),
      bottomNavigationBar: BottomNavBar(state: true),
    );
  }
}
