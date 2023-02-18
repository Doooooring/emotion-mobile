import "package:flutter/material.dart";

class CircleButton extends StatefulWidget {
  const CircleButton(
      {Key? key,
      required this.backgroundColor,
      required this.overlayColor,
      required this.icon,
      required this.action})
      : super(key: key);

  final Color backgroundColor;
  final Color overlayColor;
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
        widget.action!;
      },
      child: Image.asset(widget.icon),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
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
    return SizedBox(
        width: double.infinity, height: 800, child: Column(children: [SizedBox(
      child : Image.asset("assets/images/alert.png")
    )]));
  }
}
