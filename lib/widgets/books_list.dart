import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/screens/screens.dart';

import 'widgets.dart';

class BooksList extends StatefulWidget {
  final isList;

  const BooksList({Key key, this.isList}) : super(key: key);
  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
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
              child: CustomScrollView(
                controller: _scrollController,
                primary: false,
                slivers: <Widget>[
                  !widget.isList
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return index >= state.articles.length
                                ? BottomLoader()
                                : BookListTile(book: state.articles[index]);
                          },
                          childCount: state.hasReachedMax
                              ? state.articles.length
                              : state.articles.length + 1,
                        ))
                      : SliverPadding(
                          padding: EdgeInsets.all(16.0),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2 / 3,
                              crossAxisCount: 3,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return index >= state.articles.length
                                    ? BottomLoader()
                                    : BookGridTile(book: state.articles[index]);
                              },
                              childCount: state.hasReachedMax
                                  ? state.articles.length
                                  : state.articles.length + 1,
                            ),
                          ))
                ],
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
