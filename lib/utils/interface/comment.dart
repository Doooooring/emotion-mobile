Map Month = {
  "1": "Jan",
  "2": "Feb",
  "3": "Mar",
  "4": "Apr",
  "5": "May",
  "6": "Jun",
  "7": "Jul",
  "8": "Aug",
  "9": "Sep",
  "10": "Oct",
  "11": "Nov",
  "12": "Dec"
};

// data type
class CommentPageData {
  CommentPageData(this.emotion, this.diary, this.comment);

  final String emotion;
  final String diary;
  final List<Comment> comment;

  factory CommentPageData.fromJson(Map data) {
    String emotion = data["emotion"];
    String diary = data["content"];

    List<Comment> comments = data["comment"].length == 0
        ? []
        : data["comment"].map<Comment>((Map comment) {
            return Comment.fromJson(comment);
          }).toList();

    return CommentPageData(emotion, diary, comments);
  }
}

class Comment {
  Comment(this.order, this.date, this.type, this.comment);

  final int order;
  final String date;
  final String type;
  final String comment;

  factory Comment.fromJson(Map data) {
    int year = data["date"].year;
    int month = data["date"].month;
    String monthToStr = Month[month.toString()];
    int day = data["date"].day;

    String dateToStr = "${monthToStr} ${day} ${year}";

    int order = data["order"];
    String date = dateToStr;
    String type = data["role"];
    String comment = data["commentContent"];

    return Comment(order, date, type, comment);
  }
}
