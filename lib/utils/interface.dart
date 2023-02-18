class Diary {
  Diary({this.id, this.emotion, this.content});

  final int? id;
  final String? emotion;
  final String? content;
}

class TempDiary {
  TempDiary({this.diaryId, this.tempEmotion});

  final int? diaryId;
  final String? tempEmotion;
}

class EmotionResult {
  EmotionResult(
      {this.year,
      this.month,
      this.day,
      this.emotion,
      this.emotionText,
      this.sentimentalLevel,
      this.recommend});

  final int? year;
  final int? month;
  final int? day;
  final String? emotion;
  final String? emotionText;
  final double? sentimentalLevel;
  final String? recommend;
}

