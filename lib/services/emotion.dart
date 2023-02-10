import 'package:firstproject/page/emotion_result.dart';
import 'package:flutter/material.dart';

import "../repositories/diary.dart";

DiaryRepositories repository = new DiaryRepositories();

class EmoticonServices {
  Future<Map> getEmotionMonth(
      int year, int month, void Function(bool) setIsLoading) async {
    Map result = await DiaryRepositories().getDiaryMonth(year, month);

    return {};
  }

  Future<String> getEmotion(DateTime date, String text) async {
    Map result = await repository.postDiary(date, text);
    String emotion = result["emotion"];
    return emotion;
  }

  void saveDiaryText(
      int? id,
      DateTime dateSelected,
      String text,
      void Function(String, int?, String?, String?) setCurDate,
      void Function(bool) setEmotionSelectorUp,
      void Function(String?) setCurTempEmotion) async {
    if (id == null) {
      Map result = await repository.postDiary(dateSelected, text);
      String today = dateSelected.day.toString();
      int curId = result["diaryId"];
      String tempEmotion = result["tempEmotion"];
      setCurDate(today, curId, text, null);
      setCurTempEmotion(tempEmotion);
      setEmotionSelectorUp(true);
    } else {
      Map result = await repository.patchDiary(id, text, null, "content");
      String today = dateSelected.day.toString();
      String tempEmotion = result["tempEmotion"];
      setCurDate(today, id, text, null);
      setCurTempEmotion(tempEmotion);
      setEmotionSelectorUp(true);
    }
  }

  //set Up the emotion selector when tap the emoticon to revise
  void reviseTempEmotion(int id, void Function(String?) setTempEmotion,
      void Function(bool) setEmotionSelectorUp) async {
    try {
      Map response = await repository.getDiary(id);
      String? tempEmotion = response["tempEmotion"];
      setTempEmotion(tempEmotion);
      setEmotionSelectorUp(true);
    } catch (e) {}
  }

  //set total emotion based on cur temp emotion
  void reviseEmotion(
    int id,
    String emotion,
    DateTime dateSelected,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    void Function(String, String?, String?, String?) setCurDate,
  ) async {
    try {
      Map response = await repository.patchDiary(id, null, emotion, "emotion");
      if (response["success"] == true) {
        String today = dateSelected.day.toString();
        setCurDate(today, null, null, emotion);
        setEmotionSelectorUp(false);
        setInputEmotionUp(false);
      } else {
        //toast up?
      }
    } catch (e) {
      Error();
    }
  }

  void postDiary(
      DateTime dateSelected,
      String diary,
      Map curDates,
      void Function(String, int) setCurDates,
      void Function(bool) setEmotionSelectorUp) async {
    try {
      Map result = await repository.postDiary(dateSelected, diary);
      Map data = result["data"];
      int curId = data["diaryId"];
      String tempEmotion = data["tempEmotion"];
      setCurDates(dateSelected.day.toString(), curId);
    } catch (e) {
      Error();
    }
  }

  void getResultPage(
    Navigator navigator,
    BuildContext context,
    MaterialPageRoute materialPageRoute,
    DateTime dateSelected,
    int id,
  ) async {
    Map response = await repository.getDiaryResult(id);
    String emotion = response["emotion"];
    String emotionText = response["emotionText"];
    double sentimentLevel = response["sentimentalLevel"];
    String recommend = response["recommend"];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmotionResult(
                date: dateSelected,
                emotion: emotion,
                emotionText: emotionText,
                sentimentLevel: sentimentLevel,
                recommend: recommend)));
  }
}
