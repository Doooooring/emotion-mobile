import 'dart:convert';

import 'package:http/http.dart' as http;

import "../asset/url.dart";

class DiaryRepositories {
  //return {
  // data : {
  //   "1" : {
  //       "id" : int,
  //       "emotion" : "String",
  //       "content" : "String"
  //   },
  //   ...
  // }
  //}

  Future<Map<String, Map>> getDiaryMonth(int year, int month) async {
    Uri endPoint =
        Uri.parse('$HOST_URL/diary/month?year=${year}&month=${month}');

    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});
    dynamic result = json.decode(utf8.decode(response.bodyBytes));
    return Map<String, Map>.from(result["result"]);
  }

  // return {"success": true,
  // "message": "success",
  // "data": {
  // "diaryId": int,
  // "tempEmotion": string
  // }
  // }
  Future<Map> postDiary(DateTime date, String text) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary');
    var bodyEncoded = json.encode({
      "year": date.year,
      "month": date.month,
      "day": date.day,
      "content": text
    });

    http.Response response = await http.post(endPoint,
        body: bodyEncoded, headers: {"Content-Type": "application/json"});

    dynamic result = json.decode(utf8.decode(response.bodyBytes));
    return Map.from(result["result"]);
  }

  // case1
  // return {
  //    "success" : true
  //    "message" : ""
  //    "data"    : {
  //        "tempEmotion" : happy
  //     }
  // }
  //
  // case2
  // return {
  //    "success" : true
  //    "message" : ""
  //    "result"    : "success"
  //     }
  // }

  patchDiary(int id, String? text, String? emotion, String type
      //type = content or emotion
      ) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/${id}?type=${type}');

    Map body = type == "content" ? {"content": text} : {"emotion": emotion};

    var bodyEncoded = json.encode(body);

    http.Response response = await http.patch(endPoint,
        body: bodyEncoded, headers: {"Content-Type": "application/json"});

    dynamic result = json.decode(utf8.decode(response.bodyBytes));

    return type == "content" ? result["result"] : result["success"];
  }

  // return {
  //  content : string,
  //  tempEmotion : string,
  //  emotion : string
  // }
  getDiary(int id) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/${id}');

    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});

    dynamic result = json.decode(utf8.decode(response.bodyBytes));

    return result["result"];
  }

//   return {
//      "data" :{
//      "year" : int,
//      "month" : int,
//      "day" : int,
//      "emotion" : string,
//      "emotionText" : string,
//      "sentimentalLevel" : float,
//      "title" : string,
//      "videoUrl" : string
//      }
//   }

  getDiaryResult(int? id) async {
    Uri endPoint = Uri.parse('$HOST_URL/diary/result/${id}');
    http.Response response =
        await http.get(endPoint, headers: {"Content-Type": "application/json"});

    dynamic result = json.decode(utf8.decode(response.bodyBytes));
    return result["result"];
  }
}
