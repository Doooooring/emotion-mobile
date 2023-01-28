import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import "input_emotion.dart" as input_emotion;

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

class CalanderWrapper extends StatefulWidget {
  const CalanderWrapper({Key? key}) : super(key: key);

  @override
  State<CalanderWrapper> createState() => _CalanderWrapperState();
}

class _CalanderWrapperState extends State<CalanderWrapper> {
  String dateSelected = "null";
  void setDateSelected(String date) {
    setState(() {
      dateSelected = date;
    });
  }

  bool inputEmotionUp = false;
  void setInputEmotionUp(bool state) {
    setState(() {
      inputEmotionUp = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("ha",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                backgroundColor: Colors.blue,
              ))),
      body: Wrap(children: [
        SizedBox(
          height: 800,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                    // child: IconButton(
                    //    onPressed: () {
                    //      setInputEmotionUp(true);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: const input_emotion.EmotionWrapper(),
                    //         ));
                    //     },
                    //     icon: Icon(Icons.add_circle))),
                  ),
                  TableCalendar(
                      onDaySelected: (selectedDay, focusedDay) {
                        List<String> dayToArray =
                            selectedDay.toString().split(' ');
                        String ymd = dayToArray[0];
                        String dateInForm = getDate(ymd);
                        developer.log(dateInForm);
                        setDateSelected(dateInForm);
                        setInputEmotionUp(true);
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2022, 1, 1),
                      lastDay: DateTime.utc(2023, 12, 30)),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                child: input_emotion.EmotionWrapper(
                    dateSelected: dateSelected,
                    setInputEmotionUp: setInputEmotionUp),
                width: 430,
                left: 0,
                top: inputEmotionUp ? 50 : 800,
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape:
            CircularNotchedRectangle(), // ← carves notch for FAB in BottomAppBar
        color: Colors.white,
        notchMargin: 10,
        child: SizedBox(
          width: double.infinity,
          height: 63,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color.fromRGBO(0, 0, 0, 0.1), Colors.black],
                  begin: Alignment.topCenter,
                      end : Alignment.bottomCenter
                )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  BottomAppBar(
                    // ****** APP BAR ******************
                    clipBehavior: Clip.antiAlias,
                    shape:
                        CircularNotchedRectangle(), // ← carves notch for FAB in BottomAppBar
                    color: Colors.white,
                    elevation: 0,
                    // ↑ use .withAlpha(0) to debug/peek underneath ↑ BottomAppBar
                    notchMargin: 12,
                    child: SizedBox(width: double.infinity, height: 60),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Color(0xffFAE297),
          shape: const CircleBorder(),
          onPressed: () {},
          child: Icon(
            Icons.house,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
