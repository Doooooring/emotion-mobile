import "dart:convert";

import "package:aeye/asset/url.dart";
import "package:aeye/controller/loginController.dart";
import 'package:http/http.dart' as http;

class BardRepositories {
  LoginController loginController = new LoginController();

  Future<List> getAdvice(
      String name, int age, String temperament, String content) async {
    Map tokens = await loginController.getTokens();
    Uri endPoint = Uri.parse('$HOST_URL/child/advice/bard');
    // var bodyEncoded = json.encode({
    //   "childName": name,
    //   "childAge": age,
    //   "childTemperament": temperament,
    //   "content": content
    // });
    //
    // print(bodyEncoded);

    var bodyEncoded = json.encode({
      "childName": name,
      "childAge": age,
      "childTemperament": temperament,
      "content": content
    });
    try {
      http.Response response =
          await http.post(endPoint, body: bodyEncoded, headers: {
        "Content-Type": "application/json",
        "Authorization": tokens["access"],
        "cookie": tokens["refresh"],
      });

      Map<String, dynamic> responseEncode =
          json.decode(utf8.decode(response.bodyBytes));

      print(responseEncode);

      List result = responseEncode["result"];

      return result;
    } catch (e) {
      print("is empty result");
      return [];
    }
    ;
  }
}
