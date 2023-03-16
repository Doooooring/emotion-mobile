import "dart:convert";

import "package:aeye/asset/url.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:jwt_decode/jwt_decode.dart";

class LoginController {
  FlutterSecureStorage storage = FlutterSecureStorage();

  //회원 가입
  Future<bool> signUp(String name, String email, String password) async {
    Uri endPoint = Uri.parse('$HOST_URL/auth/signup');
    var bodyEncoded =
        json.encode({"name": name, "email": email, "password": password});
    http.Response response = await http.post(endPoint, body: bodyEncoded);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //로그인
  Future<Map<String, String?>> signIn(String id, String password) async {
    Uri endPoint = Uri.parse('$HOST_URL/auth/login');
    var bodyEncoded = json.encode({"id": id, "password": password});

    http.Response response = await http.post(endPoint, body: bodyEncoded);
    if (response.statusCode == 200) {
      String? rawCookie = response.headers["set-cookie"];
      if (rawCookie == null) {
        print("fail");
        return {"access": null};
      }
      dynamic result = json.decode(utf8.decode(response.bodyBytes));
      Map body = result["result"];
      String accessToken = body["access_token"]!;
      int index = rawCookie.indexOf(";");
      String refreshToken =
          index == -1 ? rawCookie : rawCookie.substring(0, index);
      print(accessToken);
      print(refreshToken);
      await storage.write(key: "access", value: accessToken);
      await storage.write(key: "refresh", value: refreshToken);
      return {"access": accessToken, "refresh": refreshToken};
    } else {
      return {"access": null, "refresh": null};
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

  Future<bool> checkRefresh() async {
    String? refreshToken = await storage.read(key: "refresh");
    if (refreshToken == null) {
      return false;
    }
    bool isExpired = Jwt.isExpired(refreshToken);
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
