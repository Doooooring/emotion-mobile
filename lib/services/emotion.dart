import "dart:developer";

import "../repositories/diary.dart";

DiaryRepositories repository = new DiaryRepositories();

class EmotionServices {
  void getEmotionMonth(int year, int month, void Function(Map) setCurDateAll,
      void Function(bool) setIsLoading) async {
    setIsLoading(true);
    try {
      Map result = await repository.getDiaryMonth(year, month);
      if (result["success"] == false) {
        log("herherhe");
        Error();
      }
      setCurDateAll(result);
      setIsLoading(false);
    } catch (e) {
      //토스트업
      log("it's error");
      setIsLoading(false);
    }
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
    int? id,
    String emotion,
    DateTime dateSelected,
    void Function(bool) setEmotionSelectorUp,
    void Function(bool) setInputEmotionUp,
    void Function(String, int?, String?, String?) setCurDate,
  ) async {
    try {
      if (id == null) {
        return;
      }
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
      void Function(bool) setEmotionSelectorUp,
      void Function(String?) setCurTempEmotion) async {
    try {
      Map result = await repository.postDiary(dateSelected, diary);
      Map data = result["data"];
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
    double sentimentLevel = response["sentimentalLevel"];
    String recommend = response["recommend"];
    return {
      "date": dateSelected,
      "emotion": emotion,
      "emotionText": emotionText,
      "sentimentLevel": sentimentLevel,
      "recommend": recommend
    };
  }
}
