import "package:aeye/component/common/app_bar.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class Monitor extends StatefulWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(null, "babyMonitor"),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(child: VideoViewer()),
            ])));
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
    _controller = VideoPlayerController.asset('assets/videos/aeye_test.mp4');

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
