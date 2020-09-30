import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';

import 'widgets.dart';

class VideosList extends StatefulWidget {
  const VideosList({Key key}) : super(key: key);
  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  final _scrollController = ScrollController();
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = context.bloc<ArticleBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!state.hasReachedMax && _isBottom) {
            if (state.status == ArticleStatus.success &&
                !state.hasReachedMax &&
                _isBottom) {
              _articleBloc.add(Fetch());
            }
          }
        });
      },
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.failure:
            return const Center(
                child: Text("Возникли проблемы с загрузкой 😕"));
          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('Видео пока нет...'));
            }

            return Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (_, i) => Container(
                  height: 1.5,
                  color: Theme.of(context).backgroundColor,
                ),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.articles.length
                      ? BottomLoader()
                      : VideoItem(video: state.articles[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.articles.length
                    : state.articles.length + 1,
                controller: _scrollController,
              ),
            );

          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _articleBloc.add(Fetch());
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
