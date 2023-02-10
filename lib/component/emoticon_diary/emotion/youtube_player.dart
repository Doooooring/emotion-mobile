import "package:flutter/material.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class Player extends StatefulWidget {
  final String _videoID;

  Player(this._videoID);

  @override
  PlayerState createState() => PlayerState(_videoID);
}

class PlayerState extends State<Player> {
  String _videoID;

  PlayerState(this._videoID);

  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: _videoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      width: 320,
      key: ObjectKey(_controller),
      controller: _controller,
      actionsPadding: const EdgeInsets.only(left: 16.0),
      bottomActions: [
        CurrentPosition(),
        const SizedBox(width: 10.0),
        ProgressBar(isExpanded: true),
        const SizedBox(width: 10.0),
        RemainingDuration(),
        //FullScreenButton(),
      ],
    );
  }
}
