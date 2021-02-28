import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'widgets.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key key,
    @required this.article,
  }) : super(key: key);

  final Article article;
  // String artilceSlug=
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushNewScreen(context,
          screen: CategoryScreen(name: article.categoryName),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blue, Colors.green]),
            color: Color(0xFFE3E3E3),
            borderRadius: BorderRadius.circular(3)),
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Text(
          article.categoryName,
          style: TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class CarouselBloc extends StatelessWidget {
  const CarouselBloc({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      cubit: BlocProvider.of<ArticleBloc>(context),
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.failure:
            return const CarouselShimmer();
            break;
          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('Статей пока нет...'));
            }
            return CarouselArticlesWidget(articles: state.articles);
          default:
            return const CarouselShimmer();
        }
      },
    );
  }
}
