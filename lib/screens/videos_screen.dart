import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/widgets/videos_list.dart';

class VideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: BlocProvider(
            create: (_) => ArticleBloc("video")..add(Fetch()),
            child: VideosList()));
  }
}
