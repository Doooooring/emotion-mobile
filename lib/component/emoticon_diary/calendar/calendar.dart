import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../asset/imoticon_url.dart';
import '../../../asset/init_data.dart';

dynamic getDate(date) {
  Map Month = {
    "01": "Jan",
    "02": "Feb",
    "03": "Mar",
    "04": "Apr",
    "05": "May",
    "06": "Jun",
    "07": "Jul",
    "08": "Aug",
    "09": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec"
  };

  List<String> dateArray = date.split("-");
  dateArray[1] = Month[dateArray[1]];
  dynamic result = dateArray.join(" ");
  return result;
}

class Calendar extends StatefulWidget {
  const Calendar(
      {Key? key,
      required this.setDateSelected,
      required this.setInputEmotionUp,
      required this.curDates,
      required this.setDateSelectedDeformed})
      : super(key: key);
  final void Function(String) setDateSelected;
  final void Function(bool) setInputEmotionUp;
  final void Function(DateTime) setDateSelectedDeformed;
  final Map curDates;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  SizedBox buildCalendarDay({
    required String day,
    required bool selected,
    required bool isToday,
    required bool outSide,
    required String imoticon,
  }) {
    Color background = selected ? Color(0xffFAE297) : Colors.white;
    Color fontBackground = isToday ? Color(0xff65B1EF) : Colors.white;
    Color fontColor = isToday ? Colors.white : Colors.black;
    if (outSide) {
      fontColor = Colors.grey;
    }
    return SizedBox(
        child: Container(
            color: background,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(imoticon),
                  Container(
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
        String imoticon = ImageLink[info];
        return buildCalendarDay(
            day: day,
            selected: true,
            isToday: false,
            outSide: false,
            imoticon: imoticon);
      },
      prioritizedBuilder: (context, date, _) {
        String day = date.day.toString();
        Map info = InitDate[day];
        String imoticon = ImageLink[info];
        return buildCalendarDay(
            day: day,
            selected: false,
            isToday: false,
            outSide: false,
            imoticon: imoticon);
      },
      todayBuilder: (context, date, _) {
        String day = date.day.toString();
        Map info = InitDate[day];
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
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
        String imoticon = ImageLink[info];
        return buildCalendarDay(
            day: day,
            selected: false,
            isToday: false,
            outSide: false,
            imoticon: imoticon);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.month != focusedDay.month) {
            return;
          }
          List<String> dayToArray = selectedDay.toString().split(' ');
          String ymd = dayToArray[0];
          String dateInForm = getDate(ymd);
          widget.setDateSelected(dateInForm);
          widget.setInputEmotionUp(true);
        },
        headerStyle: const HeaderStyle(
          headerPadding: EdgeInsets.all(20),
          headerMargin:
              EdgeInsets.only(left: 60, top: 10, right: 60, bottom: 0),
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronIcon:
              Icon(Icons.keyboard_arrow_left, size: 40, color: Colors.black),
          leftChevronMargin: EdgeInsets.all(0),
          leftChevronPadding: EdgeInsets.all(0),
          rightChevronIcon:
              Icon(Icons.keyboard_arrow_right, size: 40, color: Colors.black),
          rightChevronMargin: EdgeInsets.all(0),
          rightChevronPadding: EdgeInsets.all(0),
          titleTextStyle: TextStyle(fontSize: 25.0),
        ),
        calendarBuilders: calendarBuilders(),
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(1998, 1, 1),
        lastDay: DateTime.utc(2023, 12, 30));
  }
}
