import 'dart:convert';

import 'package:http/http.dart' as http;

import "../asset/url.dart";

class DiaryRepositories {
  getDiaryMonth(int year, int month) async {
    Uri endPoint =
        Uri.parse('$HOST_URL/diary/month/?year=${year}&month=${month}');
    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    return result;
  }

  postDiary(DateTime date, String text) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary');
    var bodyEncoded = json.encode({
      "year": date.year,
      "month": date.month,
      "date": date.day,
      "content": text
    });
    http.Response response = await http.post(endPoint,
        body: bodyEncoded, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    return result;
  }

  patchDiary(String id, String text, String emotion) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/:${id}');
    var bodyEncoded = json.encode({"emotion": emotion, "content": text});
    http.Response response = await http.post(endPoint,
        body: bodyEncoded, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    return result;
  }

  getDiary(String id) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/:${id}');
    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    return result;
  }

  getTempDiary(String id) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/temp/:${id}');
    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(response.body);
    return result;
  }
}
