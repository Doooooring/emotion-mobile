import "../repositories/diary.dart";

class EmoticonServices {
  Future<Map> getEmotionMonth(
      int year, int month, void Function(bool) setIsLoading) async {
    Map result = await DiaryRepositories().getDiaryMonth(year, month);

    return {};
  }

  Future<String> getEmotion(DateTime date, String text) async {
    Map result = await DiaryRepositories().postDiary(date, text);
    String emotion = result["emotion"];
    return emotion;
  }
}
