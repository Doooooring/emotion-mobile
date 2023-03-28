import "dart:ui";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";
import "package:video_player/video_player.dart";

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
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final LocalNotificationController localNotificationController = Get.find();
    return ElevatedButton(
      onPressed: () {
        print("here");
        Uri url = Uri.parse(
            "https://www.google.co.kr/maps/search/%EC%86%8C%EC%95%84%EA%B3%BC?hl=ko");
        _launchUrl(url);
        // localNotificationController.messaging = false.obs;
        // Get.back();
      },
      child: Container(
        width: 80,
        height: 80,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset(width: 60, height: 60, widget.icon)]),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0),
          ),
          backgroundColor: Colors.red
          // <-- Button color
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

class _AlertWrapperState extends State<AlertWrapper>
    with TickerProviderStateMixin {
  bool isViewing = false;
  void setIsViewing(bool state) {
    setState(() {
      isViewing = state;
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 30),
    vsync: this,
  )..addListener(() {
      if (mounted) {
        setState(() {});
      }
      ;
    });

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double alertLogoSize = 150;

    double curValue = _animation.value * 900;

    int iteration2 = (curValue / 30).floor();

    double addWidth2 = curValue - 30 * iteration2;

    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SingleChildScrollView(
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
                Text("It looks like",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text("your baby had a fall",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text("Check on your baby!",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))
              ])),
              SizedBox(height: 20),
              Container(child: VideoViewer()),
              SizedBox(height: 30),
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(children: [
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80 + addWidth2,
                              width: 80 + addWidth2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromRGBO(255, 0, 0, 0.1)),
                            ),
                          ])),
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleButton(
                                backgroundColor: Colors.red,
                                icon: "assets/images/sos.png",
                                action: () {}),
                          ])),
                ]),
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                      child: Text("Baby is Okay",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                              color: Colors.grey)))),
            ]),
          ),
        ),
      ),
    ]);
  }
}

class VideoViewer extends StatefulWidget {
  const VideoViewer({Key? key}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/aeye_edited.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
        ],
      ),
    );
  }
}
