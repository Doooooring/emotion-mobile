import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../asset/imoticon_url.dart';
import '../../../asset/init_data.dart';

SizedBox buildCalendarDay(
    {required String day,
    required bool selected,
    required bool isToday,
    required bool outSide,
    required String imoticon,
    required Color back}) {
  Color fontBackground = isToday
      ? Color(0xff65B1EF)
      : imoticon == "assets/images/mean.png"
          ? Colors.white
          : Color(0xffFFF6DA);
  Color fontColor = isToday ? Colors.white : Colors.black;

  if (outSide) {
    fontColor = Colors.grey;
  }

  return SizedBox(
      child: Container(
          padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
          decoration: BoxDecoration(
              color: back, borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(width: 30, imoticon),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: fontBackground),
                    child: Text(style: TextStyle(color: fontColor), day))
              ])));
}

CalendarBuilders calendarBuilders() {
  return CalendarBuilders(
    selectedBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: true,
          isToday: false,
          outSide: false,
          imoticon: emoticon,
          back: back);
    },
    todayBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: true,
          outSide: false,
          back: back,
          imoticon: emoticon);
    },
    rangeStartBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          back: back,
          imoticon: emoticon);
    },
    rangeEndBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          back: back,
          imoticon: emoticon);
    },
    outsideBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[null];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: true,
          back: Colors.white,
          imoticon: emoticon);
    },
    disabledBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          back: back,
          imoticon: emoticon);
    },
    holidayBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String emoticon = ImageLink[info["emotion"]];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          back: back,
          imoticon: emoticon);
    },
    defaultBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      Color back = info["id"] == null ? Colors.white : Color(0xffFFF6DA);
      String emoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          back: back,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: emoticon);
    },
  );
}
