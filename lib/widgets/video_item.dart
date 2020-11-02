import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/video_fullscreen.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
      onTap: () => pushNewScreen(context,
          screen: VideoFullScreen(
              title: video.title,
              controller: YoutubePlayerController(
                  initialVideoId: video.url.split("=")[1],
                  flags: YoutubePlayerFlags(
                      autoPlay: true,
                      hideThumbnail: true,
                      controlsVisibleAtStart: true,
                      captionLanguage: 'ru'))),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino),
      child: Column(
        children: <Widget>[
          const SizedBox(
            width: 5,
          ),
          Container(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              video.images.isEmpty
                  ? Image.asset(
                      "assets/header_logo.png",
                      height: MediaQuery.of(context).size.height / 3,
                    )
                  : CachedNetworkImage(
                      colorBlendMode: BlendMode.darken,
                      color: Colors.transparent.withOpacity(0.7),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/header_logo.png"),
                      placeholder: (context, url) =>
                          Image.asset("assets/header_logo.png"),
                      fit: BoxFit.cover,
                      imageUrl: video.images[0]["src"]),
              Image.asset("assets/youtube_icon.png")
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
                const SizedBox(
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
