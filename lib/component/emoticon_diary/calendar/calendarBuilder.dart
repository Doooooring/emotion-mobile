import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../asset/imoticon_url.dart';
import '../../../asset/init_data.dart';

SizedBox buildCalendarDay({
  required String day,
  required bool selected,
  required bool isToday,
  required bool outSide,
  required String imoticon,
}) {
  Color background =
      selected ? Color(0xffFAE297) : Color.fromRGBO(250, 250, 250, 1);
  Color fontBackground =
      isToday ? Color(0xff65B1EF) : Color.fromRGBO(250, 250, 250, 1);
  Color fontColor = isToday ? Colors.white : Colors.black;
  if (outSide) {
    fontColor = Colors.grey;
  }
  return SizedBox(
      child: Container(
          color: background,
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
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: true,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
    todayBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: true,
          outSide: false,
          imoticon: imoticon);
    },
    rangeStartBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
    rangeEndBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
    outsideBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[null];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: true,
          imoticon: imoticon);
    },
    disabledBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
    holidayBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
    defaultBuilder: (context, date, _) {
      String day = date.day.toString();
      Map info = InitDate[day];
      String imoticon = ImageLink[info["emotion"]];
      return buildCalendarDay(
          day: day,
          selected: false,
          isToday: false,
          outSide: false,
          imoticon: imoticon);
    },
  );
}
