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

      Map<String, dynamic> responseEncode = {
        "success": true,
        "code": 200,
        "message": "success",
        "result": [
          {
            "index": 1,
            "title": "Make Vegetables Fun",
            "content":
                "There are many ways to make vegetables fun for kids. You can cut them into fun shapes, let them help you cook them, or serve them with a dipping sauce. You can also try making vegetable pizzas, quesadillas, or other fun dishes that kids will enjoy."
          },
          {
            "index": 2,
            "title": "Set a Good Example",
            "content":
                "Kids learn by watching the adults in their lives. If you want your child to eat vegetables, make sure you're eating them too. Let them see you enjoying vegetables and they're more likely to want to try them."
          },
          {
            "index": 3,
            "title": "Don't Give Up",
            "content":
                "It may take some time and effort, but eventually your child will come around to eating vegetables. Don't give up if they don't like them right away. Keep offering them different vegetables and eventually they'll find some that they like."
          },
          {
            "index": 4,
            "title": "Make Vegetables Available",
            "content":
                "Make sure that vegetables are always available to your child. Keep them washed and cut up in the refrigerator so they can grab them whenever they're hungry. You can also try serving them with every meal."
          },
          {
            "index": 5,
            "title": "Be Patient",
            "content":
                "It takes time for kids to develop a taste for vegetables. Be patient and keep offering them different vegetables. Eventually they'll come around."
          }
        ]
      };
      // json.decode(utf8.decode(response.bodyBytes));

      List result = responseEncode["result"];
      print("is result");
      print(result);
      return result;
    } catch (e) {
      print("is empty result");
      return [];
    }
    ;
  }
}
