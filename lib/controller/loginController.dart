import "dart:convert";

import "package:aeye/asset/url.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:jwt_decode/jwt_decode.dart";

class LoginController {
  FlutterSecureStorage storage = FlutterSecureStorage();

  //회원 가입
  Future<bool> signUp(String name, String email, String password) async {
    print(name);
    print(email);
    print(password);
    Uri endPoint = Uri.parse('$HOST_URL/auth/signup');
    var bodyEncoded =
        json.encode({"email": email, "name": name, "password": password});
    http.Response response = await http.post(
      endPoint,
      headers: {"Content-Type": "application/json"},
      body: bodyEncoded,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //로그인
  Future<Map<String, String?>> signIn(String id, String password) async {
    Uri endPoint = Uri.parse('$HOST_URL/auth/login');
    var bodyEncoded = json.encode({"email": id, "password": password});
    http.Response response = await http.post(endPoint,
        headers: {"Content-Type": "application/json"}, body: bodyEncoded);
    if (response.statusCode == 200) {
      String? rawCookie = response.headers["set-cookie"];
      String? refreshToken = null;
      if (rawCookie != null) {
        int index = rawCookie.indexOf(";");
        refreshToken = index == -1 ? rawCookie : rawCookie.substring(0, index);
      }
      dynamic body = json.decode(utf8.decode(response.bodyBytes));
      String accessToken = body["accessToken"]!;
      await storage.write(key: "access", value: accessToken);
      await storage.write(key: "refresh", value: refreshToken);
      return {"access": accessToken, "refresh": refreshToken};
    } else {
      return {"access": null, "refresh": null};
    }
  }

  Future<Map<String, String>> chooseRole(String role, String? code) async {
    Uri endPoint = Uri.parse('$HOST_URL/auth/user/code');
    var bodyEncoded = json.encode({"role": role, "code": code});
    if (role == "main") {
      Map tokens = await getTokens();
      String access = tokens["access"]!;
      String refresh = tokens["refresh"]!;
      http.Response response = await http.patch(endPoint,
          body: bodyEncoded,
          headers: {
            "Content-Type": "application/json",
            "authorization": access,
            "cookie": refresh
          });
      dynamic result = json.decode(utf8.decode(response.bodyBytes));
      if (result["success"] == true) {
        return {"code": result["code"]};
      } else {
        return {"code": "fail"};
      }
    } else {
      Map tokens = await getTokens();
      String access = tokens["access"]!;
      String refresh = tokens["refresh"]!;
      http.Response response = await http.patch(endPoint,
          body: bodyEncoded,
          headers: {
            "Content-Type": "application/json",
            "authorization": access,
            "cookie": refresh
          });
      dynamic result = json.decode(utf8.decode(response.bodyBytes));
      if (result["success"] == true) {
        return {"code": "done"};
      } else {
        return {"code": "fail"};
      }
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

  Future<Map> getTokens() async {
    String? access = await storage.read(key: "access");
    String? refresh =
        await storage.read(key: "refresh"); //header refresh onBoarding
    return {"access": access, "refresh": refresh};
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
