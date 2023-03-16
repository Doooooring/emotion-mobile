import "dart:convert";

import "package:aeye/asset/url.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:jwt_decode/jwt_decode.dart";

class LoginController {
  FlutterSecureStorage storage = FlutterSecureStorage();

  //회원 가입
  Future<bool> singUp(String id, String password) async {
    Uri endPoint = Uri.parse('$HOST_URL/login');
    var bodyEncoded = json.encode({"id": id, "password": password});
    http.Response response = await http.post(endPoint, body: bodyEncoded);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //로그인
  Future<bool> signIn(String id, String password) async {
    Uri endPoint = Uri.parse('$HOST_URL/login');
    var bodyEncoded = json.encode({"id": id, "password": password});
    http.Response response = await http.post(endPoint, body: bodyEncoded);
    if (response.statusCode == 200) {
      dynamic result = json.decode(utf8.decode(response.bodyBytes));
      Map body = result["result"];
      String accessToken = body["access_token"]!;
      String refreshToken = body["refresh_token"];

      await storage.write(key: "access", value: accessToken);
      await storage.write(key: "refresh", value: refreshToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkAccess() async {
    String? accessToken = await storage.read(key: "access");
    if (accessToken == null) {
      return false;
    }
    bool isExpired = Jwt.isExpired(accessToken);
    return isExpired;
  }

  Future<String> getAccess() async {
    Uri endPoint = Uri.parse('$HOST_URL/login');
    http.Response response =
        await http.get(endPoint); //header refresh onBoarding
    return "";
  }

  Future<bool> getRefresh() async {
    String? accessToken = await storage.read(key: "access");
    if (accessToken == null) {
      return false;
    }
    bool isExpired = Jwt.isExpired(accessToken);

    String? refreshToken = await storage.read(key: "refresh");
    if (refreshToken == null) {
      return false;
    }
    Uri endPoint = Uri.parse('$HOST_URL/login');
    return true;
  }
}
