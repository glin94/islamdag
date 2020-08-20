import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';

class VideoItem extends StatelessWidget {
  final Article article;

  const VideoItem({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7,
        child: Column(
          children: <Widget>[
            Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 70),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    article.images == null
                        ? Image.asset(
                            "assets/header_logo.png",
                            height: MediaQuery.of(context).size.height / 3,
                          )
                        : CachedNetworkImage(
                            errorWidget: (context, url, error) => Image.asset(
                                "assets/header_logo.png",
                                height: MediaQuery.of(context).size.height / 3),
                            placeholder: (context, url) => Image.asset(
                                "assets/header_logo.png",
                                height: MediaQuery.of(context).size.height / 3),
                            fit: BoxFit.cover,
                            imageUrl: article.images[0]["src"]),
                    Icon(
                      Icons.play_arrow,
                      size: MediaQuery.of(context).size.height / 4,
                      color: Colors.black.withOpacity(.7),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height / 70,
                left: MediaQuery.of(context).size.height / 40,
                bottom: MediaQuery.of(context).size.height / 40,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(article.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .apply(fontWeightDelta: 1))),
                ],
              ),
            )
          ],
        ));
  }
}
