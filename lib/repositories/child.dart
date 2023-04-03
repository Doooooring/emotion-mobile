import 'dart:convert';

import "package:aeye/asset/url.dart";
import "package:aeye/controller/loginController.dart";
import 'package:http/http.dart' as http;

class ChildRepositories {
  LoginController loginController = new LoginController();

  Future<Map<String, dynamic>> getTemperament() async {
    Map tokens = await loginController.getTokens();
    Uri endPoint = Uri.parse('$HOST_URL/child/advice');
    http.Response response = await http.get(endPoint, headers: {
      "Content-Type": "application/json",
      "Authorization": tokens["access"],
      "cookie": tokens["refresh"]
    });
    print(response);
    Map<String, dynamic> result =
        json.decode(utf8.decode(response.bodyBytes))["result"];
    return result;
  }

  Future<Map> postTemperament(String name, String temperament) async {
    Map tokens = await loginController.getTokens();
    Uri endPoint = Uri.parse('$HOST_URL/child/advice');

    var bodyEncoded = json.encode({"name": name, "temperament": temperament});

    http.Response response =
        await http.post(endPoint, body: bodyEncoded, headers: {
      "Content-Type": "application/json",
      "Authorization": tokens["access"],
      "cookie": tokens["refresh"]
    });
    Map? result = json.decode(utf8.decode(response.bodyBytes))["result"];
    if (result != null) {
      print(result);
      return {"id": result["childId"].toString()};
    } else {
      return {"id": null};
    }
  }

  Future<bool> patchTemperament(
      String id, String name, String temperament) async {
    Map tokens = await loginController.getTokens();
    Uri endPoint = Uri.parse('$HOST_URL/child/advice/${id}');

    var bodyEncoded = json.encode({"name": name, "temperament": temperament});

    http.Response response =
        await http.patch(endPoint, body: bodyEncoded, headers: {
      "Content-Type": "application/json",
      "Authorization": tokens["access"],
      "cookie": tokens["refresh"]
    });
    Map<String, bool> result = json.decode(utf8.decode(response.bodyBytes));
    return result["success"]!;
  }
}
