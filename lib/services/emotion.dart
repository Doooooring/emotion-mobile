import 'package:aeye/utils/interface/comment.dart';

import "../repositories/diary.dart";

DiaryRepositories repository = new DiaryRepositories();

class EmotionServices {
  Future<bool> getEmotionMonth(
    int year,
    int month,
    void Function(Map<String, Map>) setCurDateAll,
  ) async {
    try {
      Map<String, Map> result = await repository.getDiaryMonth(year, month);
      setCurDateAll(result);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveDiaryText(
      int? id,
      DateTime dateSelected,
      String text,
      void Function(String, int?, String?, String?) setCurDate,
      void Function(String?) setCurTempEmotion) async {
    try {
      if (id == null) {
        Map result = await repository.postDiary(dateSelected, text);
        String today = dateSelected.day.toString();
        int curId = result["diaryId"];
        String tempEmotion = result["tempEmotion"];
        setCurDate(today, curId, text, null);
        setCurTempEmotion(tempEmotion);
        return true;
      } else {
        Map result = await repository.patchDiary(id, text, null, "content");
        String today = dateSelected.day.toString();
        String tempEmotion = result["tempEmotion"];
        setCurDate(today, id, text, null);
        setCurTempEmotion(tempEmotion);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  //set Up the emotion selector when tap the emoticon to revise
  Future<bool> reviseTempEmotion(int id, void Function(String?) setTempEmotion,
      void Function(bool) setEmotionSelectorUp) async {
    try {
      Map response = await repository.getDiary(id);
      String? tempEmotion = response["tempEmotion"];
      setTempEmotion(tempEmotion);
      setEmotionSelectorUp(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  //set total emotion based on cur temp emotion
  Future<bool> reviseEmotion(
    int? id,
    String emotion,
    DateTime dateSelected,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    void Function(String, int?, String?, String?) setCurDate,
  ) async {
    try {
      if (id == null) {
        return false;
      }

      bool response = await repository.patchDiary(id, null, emotion, "emotion");

      if (response) {
        String today = dateSelected.day.toString();
        setCurDate(today, null, null, emotion);
        setEmotionSelectorUp(false);
        setInputEmotionUp(false);
        return true;
      } else {
        return false;
        //toast up?
      }
    } catch (e) {
      Error();
      return false;
    }
  }

  void postDiary(
      DateTime dateSelected,
      String diary,
      Map curDates,
      void Function(String, int) setCurDates,
      void Function(bool) setEmotionSelectorUp,
      void Function(String?) setCurTempEmotion) async {
    try {
      Map data = await repository.postDiary(dateSelected, diary);
      int curId = data["diaryId"];
      String tempEmotion = data["tempEmotion"];
      setCurDates(dateSelected.day.toString(), curId);
      setCurTempEmotion(tempEmotion);
    } catch (e) {
      Error();
    }
  }

  Future<Map> getResultPage(
    int? id,
    DateTime dateSelected,
  ) async {
    Map response = await repository.getDiaryResult(id);
    String emotion = response["emotion"];
    String emotionText = response["emotionText"];
    double sentimentLevel = response["sentimentLevel"];
    String videoUrl = response["videoUrl"];
    String title = response["title"];
    return {
      "date": dateSelected,
      "emotion": emotion,
      "emotionText": emotionText,
      "sentimentLevel": sentimentLevel,
      "videoUrl": videoUrl,
      "title": title
    };
  }

  Future<Map> getMonthlyResult(int year, int month) async {
    Map response = await repository.getMonthlyResult(year, month);
    return response;
  }

  Future<CommentPageData> getComments(String diaryId) async {
    Map response = await repository.getComments(diaryId);
    CommentPageData commentPageData = CommentPageData.fromJson(response);
    return commentPageData;
  }

  Future<bool> postComments(String id, String comment) async {
    bool response = await repository.postComments(id, comment);
    return response;
  }
}
