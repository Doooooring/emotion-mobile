import 'package:aeye/controller/childController.dart';
import 'package:aeye/controller/userController.dart';
import 'package:aeye/page/emotion/emoticon_month_result.dart';
import 'package:aeye/page/login/login.dart';
import "package:aeye/services/emotion.dart";
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:get/get.dart";

EmotionServices emotionService = new EmotionServices();

//void Function(bool state) setIsLoading
class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key, required this.curDate, required this.curPath})
      : super(key: key);

  final DateTime? curDate;
  final String curPath;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final FlutterSecureStorage storage = Get.find();
    final UserController userController = Get.find();
    final ChildController childController = Get.find();
    String title = "";
    switch (curPath) {
      case ("init"):
        title = "A-eye";
        break;
      case ("emotionDiary"):
        title = "Diary";
        break;
      case ("babyMonitor"):
        title = "Baby Monitor";
        break;
      case ("advice"):
        title = "Advice";
        break;
      default:
        break;
    }
    ;

    if (curPath == "init") {
      return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFFF2CB),
          elevation: 0,
          centerTitle: false,
          title: SizedBox(
            child: Row(
              children: const [
                SizedBox(width: 10),
                Text("A-eye",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            PopupMenuButton(
              icon: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                      size: 30, Icons.keyboard_control, color: Colors.black)),
              iconSize: 40,
              onSelected: (result) async {
                await storage.deleteAll();
                userController.reset();
                childController.reset();
                Get.to(() => Login());
              },
              itemBuilder: (BuildContext context) => ["logout"]
                  .map((value) => PopupMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
            ),
            SizedBox(width: 10)
          ]);
    }

    if (curPath == "advice") {
      return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFFF2CB),
          elevation: 0.1,
          centerTitle: false,
          title: SizedBox(
            child: Row(
              children: [
                Text(title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            curDate != null
                ? MonthResultButton(curDate: curDate!)
                : SizedBox(width: 0),
            PopupMenuButton(
              icon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                      size: 30, Icons.keyboard_control, color: Colors.black)),
              iconSize: 40,
              onSelected: (result) async {
                await storage.deleteAll();
                userController.reset();
                childController.reset();
                Get.to(() => Login());
              },
              itemBuilder: (BuildContext context) => ["logout"]
                  .map((value) => PopupMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
            ),
            SizedBox(width: 10)
          ]);
    }

    return AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              return;
            },
          );
        }),
        backgroundColor: Color(0xffFFF2CB),
        elevation: 1.0,
        centerTitle: false,
        title: SizedBox(
          child: Row(
            children: [
              Text(title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        actions: [
          curDate != null
              ? MonthResultButton(curDate: curDate!)
              : SizedBox(width: 0),
          PopupMenuButton(
            icon: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                    size: 30, Icons.keyboard_control, color: Colors.black)),
            iconSize: 40,
            onSelected: (result) async {
              await storage.deleteAll();
              userController.reset();
              childController.reset();
              Get.to(() => Login());
            },
            itemBuilder: (BuildContext context) => ["logout"]
                .map((value) => PopupMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          SizedBox(width: 10)
        ]);
  }
}

// AppBar Header(DateTime? curDate, String curPath) {
//   FlutterSecureStorage storage = FlutterSecureStorage();
//
//   String title = "";
//   switch (curPath) {
//     case ("init"):
//       title = "A-eye";
//       break;
//     case ("emotionDiary"):
//       title = "Diary";
//       break;
//     case ("babyMonitor"):
//       title = "Baby Monitor";
//       break;
//     case ("advice"):
//       title = "Advice";
//       break;
//     default:
//       break;
//   }
//   ;
//
//   if (curPath == "init") {
//     return AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xffFFF2CB),
//         elevation: 0,
//         centerTitle: false,
//         title: SizedBox(
//           child: Row(
//             children: const [
//               SizedBox(width: 10),
//               Text("A-eye",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 35,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   )),
//             ],
//           ),
//         ),
//         actions: [
//           PopupMenuButton(
//             icon: const RotatedBox(
//                 quarterTurns: 1,
//                 child: Icon(
//                     size: 30, Icons.keyboard_control, color: Colors.black)),
//             iconSize: 40,
//             onSelected: (result) async {
//               await storage.deleteAll;
//             },
//             itemBuilder: (BuildContext context) => ["logout"]
//                 .map((value) => PopupMenuItem(
//                       value: value,
//                       child: Text(value),
//                     ))
//                 .toList(),
//           ),
//           SizedBox(width: 10)
//         ]);
//   }
//
//   if (curPath == "advice") {
//     return AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xffFFF2CB),
//         elevation: 0.1,
//         centerTitle: false,
//         title: SizedBox(
//           child: Row(
//             children: [
//               Text(title,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 35,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   )),
//             ],
//           ),
//         ),
//         actions: [
//           curDate != null
//               ? MonthResultButton(curDate: curDate)
//               : SizedBox(width: 0),
//           PopupMenuButton(
//             icon: RotatedBox(
//                 quarterTurns: 1,
//                 child: Icon(
//                     size: 30, Icons.keyboard_control, color: Colors.black)),
//             iconSize: 40,
//             onSelected: (result) async {
//               await storage.deleteAll;
//             },
//             itemBuilder: (BuildContext context) => ["logout"]
//                 .map((value) => PopupMenuItem(
//                       value: value,
//                       child: Text(value),
//                     ))
//                 .toList(),
//           ),
//           SizedBox(width: 10)
//         ]);
//   }
//
//   return AppBar(
//       leading: Builder(builder: (BuildContext context) {
//         return IconButton(
//           icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//             return;
//           },
//         );
//       }),
//       backgroundColor: Color(0xffFFF2CB),
//       elevation: 1.0,
//       centerTitle: false,
//       title: SizedBox(
//         child: Row(
//           children: [
//             Text(title,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 35,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 )),
//           ],
//         ),
//       ),
//       actions: [
//         curDate != null
//             ? MonthResultButton(curDate: curDate)
//             : SizedBox(width: 0),
//         PopupMenuButton(
//           icon: RotatedBox(
//               quarterTurns: 1,
//               child:
//                   Icon(size: 30, Icons.keyboard_control, color: Colors.black)),
//           iconSize: 40,
//           onSelected: (result) async {
//             await storage.deleteAll;
//           },
//           itemBuilder: (BuildContext context) => ["logout"]
//               .map((value) => PopupMenuItem(
//                     value: value,
//                     child: Text(value),
//                   ))
//               .toList(),
//         ),
//         SizedBox(width: 10)
//       ]);
// }

class MonthResultButton extends StatefulWidget {
  const MonthResultButton({Key? key, required this.curDate}) : super(key: key);

  final DateTime curDate;

  @override
  State<MonthResultButton> createState() => _MonthResultButtonState();
}

class _MonthResultButtonState extends State<MonthResultButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset("assets/images/heartemoticon.png"),
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmotionMonthResult(
                      year: widget.curDate.year,
                      month: widget.curDate.month,
                    )));
      },
    );
  }
}
