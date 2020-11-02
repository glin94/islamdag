import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'widgets.dart';

class ArticlesBoxFeaturedList extends StatefulWidget {
  final String categoryName;

  const ArticlesBoxFeaturedList({Key key, @required this.categoryName})
      : super(key: key);
  @override
  _ArticlesBoxFeaturedListState createState() =>
      _ArticlesBoxFeaturedListState();
}

class _ArticlesBoxFeaturedListState extends State<ArticlesBoxFeaturedList> {
  ArticleBloc _articleBloc;
  @override
  void initState() {
    super.initState();
    _articleBloc = context.bloc<ArticleBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      cubit: _articleBloc,
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.failure:
            return CardBoxShimmer(
              categoryName: widget.categoryName,
            );
            break;
          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('Статей пока нет...'));
            }
            return Column(
              children: [
                widget.categoryName.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.categoryName,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => pushNewScreen(context,
                                  screen:
                                      CategoryScreen(name: widget.categoryName),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino),
                              child: Text("все",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      )),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return LargeArticleCard(
                          article: widget.categoryName.isNotEmpty
                              ? state.articles.sublist(0, 4).toList()[index]
                              : state.articles.toList()[index]);
                    },
                    itemCount: widget.categoryName.isNotEmpty
                        ? state.articles.sublist(0, 4).length
                        : state.articles.length)
              ],
            );
          default:
            return CardBoxShimmer(
              categoryName: widget.categoryName,
            );
        }
      },
    );
  }
}
