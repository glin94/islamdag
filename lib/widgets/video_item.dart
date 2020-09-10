import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/share_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils.dart';

class VideoItem extends StatelessWidget {
  final Article video;

  const VideoItem({
    Key key,
    this.video,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (c) => VideoFullScreen(
                  title: video.title,
                  controller: YoutubePlayerController(
                      initialVideoId: video.url.split("=")[1],
                      flags: YoutubePlayerFlags(
                          autoPlay: false,
                          hideThumbnail: true,
                          hideControls: true,
                          controlsVisibleAtStart: true,
                          captionLanguage: 'ru'))))),
      child: Card(
          elevation: 7,
          child: Column(
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 70),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      video.images == null
                          ? Image.asset(
                              "assets/header_logo.png",
                              height: MediaQuery.of(context).size.height / 3,
                            )
                          : CachedNetworkImage(
                              errorWidget: (context, url, error) => Image.asset(
                                  "assets/header_logo.png",
                                  height:
                                      MediaQuery.of(context).size.height / 3),
                              placeholder: (context, url) => Image.asset(
                                  "assets/header_logo.png",
                                  height:
                                      MediaQuery.of(context).size.height / 3),
                              fit: BoxFit.cover,
                              imageUrl: video.images[0]["src"]),
                      Icon(
                        Icons.play_arrow,
                        size: MediaQuery.of(context).size.height / 4,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height / 70,
                  left: MediaQuery.of(context).size.height / 40,
                  bottom: MediaQuery.of(context).size.height / 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Text(video.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .apply(fontWeightDelta: 1))),
                    SizedBox(
                      width: 20,
                    ),
                    ShareButton(item: video)
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class VideoFullScreen extends StatelessWidget {
  final YoutubePlayerController controller;
  final String title;
  const VideoFullScreen({
    Key key,
    this.controller,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
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
          key: ObjectKey(controller),
          controller: controller,
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
