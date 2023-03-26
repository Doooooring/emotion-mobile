// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import "package:aeye/services/emotion.dart";
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;
import 'custom_icon_button.dart';
import 'format_button.dart';

EmotionServices emotionServices = EmotionServices();

Map monthMap = {
  "January": 1,
  "February": 2,
  "March": 3,
  "April": 4,
  "May": 5,
  "June": 6,
  "July": 7,
  "August": 8,
  "September": 9,
  "October": 10,
  "November": 11,
  "December": 12
};

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final Function(int difference) headerChange; //refactor
  final Function(bool state) setIsLoading;
  final Function(Map<String, Map<dynamic, dynamic>> curDate) setCurDateAll;
  final Function(
    int year,
  ) setByYear;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.headerChange, //set header change by dropdown
    required this.setByYear, //refactor
    required this.setIsLoading, //customed
    required this.setCurDateAll,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = DateFormat.yMMMM(locale).format(focusedMonth);
    List<String> yearAndMonth = text.split(" ");
    String Month = yearAndMonth[0];
    String Year = yearAndMonth[1];

    return Container(
      decoration: headerStyle.decoration,
      margin: headerStyle.headerMargin,
      padding: headerStyle.headerPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (headerStyle.leftChevronVisible)
            CustomIconButton(
              icon: headerStyle.leftChevronIcon,
              onTap: onLeftChevronTap,
              margin: headerStyle.leftChevronMargin,
              padding: headerStyle.leftChevronPadding,
            ),
          Expanded(
            child: headerTitleBuilder?.call(context, focusedMonth) ??
                GestureDetector(
                    onTap: onHeaderTap,
                    onLongPress: onHeaderLongPress,
                    child: Column(children: [
                      YearButton(
                          year: Year,
                          headerChange: headerChange,
                          setByYear: setByYear,
                          setIsLoading: setIsLoading,
                          setCurDateAll: setCurDateAll,
                          month: Month),
                      Text(
                        Month,
                        style: TextStyle(fontSize: 25),
                      )
                    ])),
          ),
          if (headerStyle.formatButtonVisible &&
              availableCalendarFormats.length > 1)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FormatButton(
                onTap: onFormatButtonTap,
                availableCalendarFormats: availableCalendarFormats,
                calendarFormat: calendarFormat,
                decoration: headerStyle.formatButtonDecoration,
                padding: headerStyle.formatButtonPadding,
                textStyle: headerStyle.formatButtonTextStyle,
                showsNextFormat: headerStyle.formatButtonShowsNext,
              ),
            ),
          if (headerStyle.rightChevronVisible)
            CustomIconButton(
              icon: headerStyle.rightChevronIcon,
              onTap: onRightChevronTap,
              margin: headerStyle.rightChevronMargin,
              padding: headerStyle.rightChevronPadding,
            ),
        ],
      ),
    );
  }
}

List<int> YearList = [
  1980,
  1981,
  1982,
  1983,
  1984,
  1985,
  1986,
  1987,
  1988,
  1989,
  1990,
  1991,
  1992,
  1993,
  1994,
  1995,
  1996,
  1997,
  1998,
  1999,
  2000,
  2001,
  2002,
  2003,
  2004,
  2005,
  2006,
  2007,
  2008,
  2009,
  2010,
  2011,
  2012,
  2013,
  2014,
  2015,
  2016,
  2017,
  2018,
  2019,
  2020,
  2021,
  2022,
  2023
];

class YearButton extends StatefulWidget {
  const YearButton(
      {Key? key,
      required this.year,
      required this.headerChange,
      required this.setByYear,
      required this.setIsLoading,
      required this.setCurDateAll,
      required this.month})
      : super(key: key);

  final String year;
  final String month;
  final Function(int) headerChange;
  final Function(int year) setByYear;
  final Function(bool state) setIsLoading;
  final Function(Map<String, Map<dynamic, dynamic>> curDate) setCurDateAll;

  @override
  State<YearButton> createState() => _YearButtonState();
}

class _YearButtonState extends State<YearButton> {
  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.year;

    return DropdownButton(
        menuMaxHeight: 150,
        value: dropDownValue,
        items: YearList.map((year) {
          return DropdownMenuItem(
              value: year.toString(), child: Text(year.toString()));
        }).toList(),
        onChanged: (value) async {
          if (value == null) {
            return;
          }
          int curYear = int.parse(dropDownValue);
          int nextYear = int.parse(value);
          widget.headerChange(nextYear - curYear);
          widget.setByYear(nextYear);
          widget.setIsLoading(true);
          await emotionServices.getEmotionMonth(
              nextYear, monthMap[widget.month], widget.setCurDateAll);
          widget.setIsLoading(false);
          setState(() {
            dropDownValue = value;
          });
        });
  }
}
