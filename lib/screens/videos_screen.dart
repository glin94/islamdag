import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/video_item.dart';

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Repository.get().getArticles("video", 0),
        builder: (c, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (c, i) => VideoItem(article: snapshot.data[i]))
              : Center(
                  child: Text(snapshot.error.toString()),
                );
        });
  }
}
