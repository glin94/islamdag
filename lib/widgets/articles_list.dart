import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';

import 'widgets.dart';

class ArticlesList extends StatefulWidget {
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
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
            return ConnectionErrorWidget(articleBloc: _articleBloc);
          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('Статей пока нет...'));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.articles.length
                    ? BottomLoader()
                    : ArticleCardItem(article: state.articles[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController,
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
