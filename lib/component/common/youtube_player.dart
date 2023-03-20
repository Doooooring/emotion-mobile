import "package:flutter/material.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class Player extends StatefulWidget {
  final String _videoID;
  final double width;

  Player(this._videoID, this.width);

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
        autoPlay: false,
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
      width: widget.width,
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
