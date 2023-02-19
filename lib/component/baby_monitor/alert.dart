import "dart:developer";
import "dart:ui";

import "package:flutter/material.dart";

class CircleButton extends StatefulWidget {
  const CircleButton(
      {Key? key,
      required this.backgroundColor,
      required this.icon,
      required this.action})
      : super(key: key);

  final Color backgroundColor;
  final String icon;
  final Function action;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.action();
      },
      child: Container(
        width: 80,
        height: 80,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset(width: 60, height: 60, widget.icon)]),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all(
            widget.backgroundColor), // <-- Button color
        // overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        //   if (states.contains(MaterialState.pressed))
        //     return widget.overlayColor; // <-- Splash color
        // }),
      ),
    );
  }
}

class AlertWrapper extends StatefulWidget {
  const AlertWrapper({
    Key? key,
    required this.isAlert,
    required this.setIsAlert,
  }) : super(key: key);

  final bool isAlert;
  final Function(bool) setIsAlert;

  @override
  State<AlertWrapper> createState() => _AlertWrapperState();
}

class _AlertWrapperState extends State<AlertWrapper> {
  bool isViewing = false;
  void setIsViewing(bool state) {
    setState(() {
      isViewing = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color viewButtonColor = isViewing ? Colors.black : Colors.white;
    String viewImage = isViewing
        ? "assets/images/cam(white).png"
        : "assets/images/cam(black).png";

    double alertLogoSize = isViewing ? 150 : 200;

    return Container(
        width: double.infinity,
        color: Colors.grey.withOpacity(0.1),
        height: 800,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(children: [
              SizedBox(height: 100),
              SizedBox(
                child: Image.asset(
                    width: alertLogoSize,
                    height: alertLogoSize,
                    "assets/images/alert.png"),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  child: Column(children: [
                Text("낙상이 감지되었습니다.", style: TextStyle(fontSize: 28)),
                SizedBox(height: 10),
                Text("아이를 확인해주세요", style: TextStyle(fontSize: 28))
              ])),
              SizedBox(height: 50),
              SizedBox(),
              SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    SizedBox(width: 90),
                    CircleButton(
                        backgroundColor: viewButtonColor,
                        icon: viewImage,
                        action: () {
                          log(isViewing.toString());
                          setIsViewing(!isViewing);
                        }),
                    CircleButton(
                        backgroundColor: Colors.red,
                        icon: "assets/images/sos.png",
                        action: () {}),
                    SizedBox(width: 90)
                  ]))
            ]),
          ),
        ));
  }
}
