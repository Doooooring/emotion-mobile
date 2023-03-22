import "dart:developer";

import 'package:aeye/utils/interface/comment.dart';

import "../repositories/diary.dart";

DiaryRepositories repository = new DiaryRepositories();

Map<String, Map> re = {
  '1': {'id': 1, 'emotion': "excited-3", 'content': null},
  '2': {
    'id': 3,
    'emotion': "excited-1",
    'content': null,
  },
  '3': {
    'id': 3,
    'emotion': "excited-4",
    'content': null,
  },
  '4': {
    'id': 3,
    'emotion': "sad-2",
    'content': null,
  },
  '5': {'id': 3, 'emotion': "sad-3", 'content': null},
  '6': {
    'id': 3,
    'emotion': "sad-1",
    'content': null,
  },
  '7': {
    'id': 3,
    'emotion': "angry-2",
    'content': null,
  },
  '8': {
    'id': 3,
    'emotion': "angry-3",
    'content':
        "I went to the hospital because Mark is not feeling well. He recovered quickly, but I had a hard time all day. I wish Mark good health.",
  },
  '9': {
    'id': 3,
    'emotion': "excited-1",
    'content': null,
  },
  '10': {
    'id': 3,
    'emotion': "excited-4",
    'content': null,
  },
  '11': {
    'id': 3,
    'emotion': "bored-1",
    'content': null,
  },
  '12': {
    'id': 1,
    'emotion': "calm-2",
    'content': null,
  },
  '13': {
    'id': 2,
    'emotion': "calm-1",
    'content': null,
  },
  '14': {
    'id': 2,
    'emotion': "anticipate-2",
    'content':
        "Nothing special today. I hope that there will be something interesting tomorrow",
  },
  '15': {
    'id': 2,
    'emotion': "anticipate-3",
    'content': null,
  },
  '16': {
    'id': 3,
    'emotion': "content-1",
    'content':
        "Today, Mark took his first steps. I feel like I could cry out of happiness. Oh, my baby is growing up!",
  },
  '17': {
    'id': 123,
    'emotion': "excited-3",
    'content':
        "Today, Mark took his first steps. I feel like I could cry out of happiness. Oh, my baby is growing up!",
  },
  '18': {
    'id': 1,
    'emotion': "angry-2",
    'content': null,
  },
  '19': {
    'id': 3,
    'emotion': "relaxed-1",
    'content': null,
  },
  '20': {
    'id': 1,
    'emotion': "bored-1",
    'content': null,
  },
  '21': {
    'id': 2,
    'emotion': "excited-3",
    'content': null,
  },
  '22': {
    'id': 1,
    'emotion': "angry-4",
    'content': null,
  },
  '23': {
    'id': 1,
    'emotion': "sad-4",
    'content': null,
  },
  '24': {
    'id': 1,
    'emotion': "tense-3",
    'content': null,
  },
  '25': {
    'id': 1,
    'emotion': "excited-1",
    'content': null,
  },
  '26': {
    'id': 3,
    'emotion': "sad-2",
    'content': null,
  },
  '27': {
    'id': 1,
    'emotion': "content-3",
    'content': null,
  },
  '28': {
    'id': 1,
    'emotion': "happy-2",
    'content': null,
  },
  '29': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '30': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '31': {
    'id': null,
    'emotion': null,
    'content': null,
  }
};

Map<String, Map> testData = {
  '1': {'id': null, 'emotion': null, 'content': null},
  '2': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '3': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '4': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '5': {'id': null, 'emotion': null, 'content': null},
  '6': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '7': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '8': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '9': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '10': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '11': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '12': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '13': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '14': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '15': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '16': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '17': {'id': null, 'emotion': null, 'content': null},
  '18': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '19': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '20': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '21': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '22': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '23': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '24': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '25': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '26': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '27': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '28': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '29': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '30': {
    'id': null,
    'emotion': null,
    'content': null,
  },
  '31': {
    'id': null,
    'emotion': null,
    'content': null,
  }
};

class EmotionServices {
  void getEmotionMonth(
      int year,
      int month,
      void Function(Map<String, Map>) setCurDateAll,
      void Function(bool) setIsLoading) async {
    try {
      Map<String, Map> result = await repository.getDiaryMonth(year, month);

      setCurDateAll(result);
      setIsLoading(true);
    } catch (e) {
      //토스트업
      print(e);
      setIsLoading(false);
    }
  }

  void saveDiaryText(
      int? id,
      DateTime dateSelected,
      String text,
      void Function(bool) setIsLoading,
      void Function(String, int?, String?, String?) setCurDate,
      void Function(bool) setEmotionSelectorUp,
      void Function(String?) setCurTempEmotion) async {
    try {
      setIsLoading(false);
      await Future.delayed(Duration(seconds: 1));
      if (id == null) {
        Map result = await repository.postDiary(dateSelected, text);

        String today = dateSelected.day.toString();
        int curId = result["diaryId"];
        String tempEmotion = result["tempEmotion"];
        setCurDate(today, curId, text, null);
        setCurTempEmotion(tempEmotion);
        setEmotionSelectorUp(true);
        setIsLoading(true);
      } else {
        Map result = await repository.patchDiary(id, text, null, "content");

        String today = dateSelected.day.toString();
        String tempEmotion = result["tempEmotion"];
        setCurDate(today, id, text, null);
        setCurTempEmotion(tempEmotion);
        setEmotionSelectorUp(true);
        setIsLoading(true);
      }
    } catch (e) {
      log(e.toString());
      setIsLoading(true);
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
      bool response = await repository.patchDiary(id, null, emotion, "emotion");

      if (response) {
        String today = dateSelected.day.toString();
        setCurDate(today, null, null, emotion);
        setEmotionSelectorUp(false);
        setInputEmotionUp(false);
      } else {
        //toast up?
      }
    } catch (e) {
      log(e.toString());
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
    Map response = await repository.postComments(id, comment);
    return response["success"];
  }
}
