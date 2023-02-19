import "dart:developer";

import 'package:flutter/material.dart';

import "./calendarBuilder.dart";
import './table-calendar/table_calendar.dart';

dynamic getDate(date) {
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

  List<String> dateArray = date.split("-");
  dateArray[1] = Month[dateArray[1]];
  dynamic result = dateArray.join(" ");
  return result;
}

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.textEditController,
    required this.setDateSelected,
    required this.setInputEmotionUp,
    required this.setCurDateAll,
    required this.setIsLoading,
    required this.curDates,
  }) : super(key: key);
  final TextEditingController textEditController;
  final void Function(DateTime) setDateSelected;
  final void Function(bool) setInputEmotionUp;
  final void Function(Map<String, Map>) setCurDateAll;
  final void Function(bool) setIsLoading;
  final Map<String, Map> curDates;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int focusedYear = DateTime.now().toUtc().year;
  void setFocusedYear(int nextYear) {
    setState(() {
      focusedYear = nextYear;
    });
  }

  int focusedMonth = DateTime.now().toUtc().month;
  void setFocusedMonth(int newMonth) {
    focusedMonth = newMonth;
  }

  int focusedDay = DateTime.now().toUtc().day;
  void setFocusedDay(int newDay) {
    focusedDay = newDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        rowHeight: 60,
        selectedDayPredicate: (selectedDay) {
          bool state = (selectedDay.year == focusedYear) &
                  (selectedDay.month == focusedMonth) &&
              (selectedDay.day == focusedDay);
          log(state.toString());
          return state;
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.month != focusedDay.month) {
            return;
          }
          if (selectedDay.isAfter(DateTime.now())) {
            return;
          }
          // List<String> dayToArray = selectedDay.toString().split(' ');
          // String ymd = dayToArray[0];
          // String dateInForm = getDate(ymd);

          Map curInfo = widget.curDates[selectedDay.day.toString()] ?? {};
          String diaryContent = curInfo["content"] ?? "";

          widget.textEditController.text = diaryContent;
          widget.setDateSelected(selectedDay);
          setFocusedYear(selectedDay.year);
          setFocusedMonth(selectedDay.month);
          setFocusedDay(selectedDay.day);
        },
        headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.all(20),
          headerMargin:
              EdgeInsets.only(left: 62, top: 10, right: 62, bottom: 0),
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronIcon: IconButton(
              onPressed: () {
                if (focusedMonth == 1) {
                  setFocusedYear(focusedYear - 1);
                  setFocusedMonth(12);
                } else {
                  setFocusedMonth(focusedMonth - 1);
                }

                widget.setDateSelected(DateTime.parse(
                    '${focusedYear}${focusedMonth.toString().padLeft(2, '0')}${focusedDay.toString().padLeft(2, '0')}'));

                emotionServices.getEmotionMonth(focusedYear, focusedMonth,
                    widget.setCurDateAll, widget.setIsLoading);
              },
              icon: Icon(Icons.keyboard_arrow_left,
                  size: 40, color: Colors.black)),
          leftChevronMargin: EdgeInsets.all(0),
          leftChevronPadding: EdgeInsets.all(0),
          rightChevronIcon: IconButton(
              onPressed: () {
                if (focusedMonth == 12) {
                  setFocusedYear(focusedYear + 1);
                  setFocusedMonth(1);
                } else {
                  setFocusedMonth(focusedMonth + 1);
                }

                widget.setDateSelected(DateTime.parse(
                    '${focusedYear}${focusedMonth.toString().padLeft(2, '0')}${focusedDay.toString().padLeft(2, '0')}'));
                emotionServices.getEmotionMonth(focusedYear, focusedMonth,
                    widget.setCurDateAll, widget.setIsLoading);
              },
              icon: Icon(Icons.keyboard_arrow_right,
                  size: 40, color: Colors.black)),
          rightChevronMargin: EdgeInsets.all(0),
          rightChevronPadding: EdgeInsets.all(0),
          titleTextStyle: TextStyle(fontSize: 25.0),
        ),
        calendarBuilders: calendarBuilders(
            widget.curDates, widget.setCurDateAll, widget.setIsLoading),
        focusedDay: DateTime.parse(
            '${focusedYear}${focusedMonth.toString().padLeft(2, '0')}${focusedDay}'),
        firstDay: DateTime.utc(1998, 1, 1),
        lastDay: DateTime.utc(2023, 12, 30));
  }
}
