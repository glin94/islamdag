import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFullScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  final String title;
  const VideoFullScreen({
    Key key,
    this.controller,
    this.title,
  }) : super(key: key);

  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          // onReady: () => widget.controller.seekTo(Duration(seconds: 3)),
          showVideoProgressIndicator: true,
          topActions: [
            CloseButton(
              color: Colors.white,
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Navigator.pop(context);
              },
            )
          ],
          key: ObjectKey(widget.controller),
          controller: widget.controller,
          actionsPadding: const EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
      ),
    );
  }
}
