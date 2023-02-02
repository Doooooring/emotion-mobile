import 'dart:convert';

import 'package:firstproject/url.dart';
import 'package:http/http.dart' as http;

class EmoticonServices {
  Future<String> getEmotion(String text) async {
    Uri endPoint = Uri.parse('$HOST_URL/emotion');
    var bodyEncoded = json.encode({"text": text});
    http.Response response = await http.post(endPoint,
        body: bodyEncoded, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    String emotion = result["emotion"];
    return emotion;
  }
}
