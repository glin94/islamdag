import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/video_fullscreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'share_button.dart';

class VideoItem extends StatelessWidget {
  final Article video;

  const VideoItem({
    Key key,
    this.video,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => VideoFullScreen(
                  title: video.title,
                  controller: YoutubePlayerController(
                      initialVideoId: video.url.split("=")[1],
                      flags: YoutubePlayerFlags(
                          autoPlay: true,
                          hideThumbnail: true,
                          controlsVisibleAtStart: true,
                          captionLanguage: 'ru'))))),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Container(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              video.images == null
                  ? Image.asset(
                      "assets/header_logo.png",
                      height: MediaQuery.of(context).size.height / 3,
                    )
                  : CachedNetworkImage(
                      colorBlendMode: BlendMode.darken,
                      color: Colors.transparent.withOpacity(0.7),
                      errorWidget: (context, url, error) => Image.asset(
                          "assets/header_logo.png",
                          height: MediaQuery.of(context).size.height / 4),
                      placeholder: (context, url) => Image.asset(
                          "assets/header_logo.png",
                          height: MediaQuery.of(context).size.height / 4),
                      fit: BoxFit.cover,
                      imageUrl: video.images[0]["src"]),
              Image.asset("assets/youtube_icon.png")
              // Icon(
              //   Icons.play_arrow,
              //   size: MediaQuery.of(context).size.height / 4,
              //   color: Colors.black.withOpacity(.7),
              // ),
            ],
          )),
          Container(color: Colors.black.withOpacity(1)),
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
                            .copyWith(fontSize: 17))),
                SizedBox(
                  width: 20,
                ),
                ShareButton(item: video)
              ],
            ),
          )
        ],
      ),
    );
  }
}
