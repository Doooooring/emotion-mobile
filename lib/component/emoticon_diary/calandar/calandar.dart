import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


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

class Calander extends StatefulWidget {
  const Calander(
      {Key? key,
      required this.setDateSelected,
      required this.setInputEmotionUp})
      : super(key: key);
  final void Function(String) setDateSelected;
  final void Function(bool) setInputEmotionUp;


  @override
  State<Calander> createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        onDaySelected: (selectedDay, focusedDay) {
          List<String> dayToArray =
          selectedDay.toString().split(' ');
          String ymd = dayToArray[0];
          String dateInForm = getDate(ymd);
          widget.setDateSelected(dateInForm);
          widget.setInputEmotionUp(true);
        },
        headerStyle: const HeaderStyle(
          headerPadding: EdgeInsets.all(20),
          headerMargin: EdgeInsets.only(
              left: 60, top: 10, right: 60, bottom: 0),
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronIcon: Icon(Icons.keyboard_arrow_left,
              size: 40, color: Colors.black),
          leftChevronMargin: EdgeInsets.all(0),
          leftChevronPadding: EdgeInsets.all(0),
          rightChevronIcon: Icon(Icons.keyboard_arrow_right,
              size: 40, color: Colors.black),
          rightChevronMargin: EdgeInsets.all(0),
          rightChevronPadding: EdgeInsets.all(0),
          titleTextStyle: TextStyle(fontSize: 25.0),
        ),
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2022, 1, 1),
        lastDay: DateTime.utc(2023, 12, 30));
  }
}
