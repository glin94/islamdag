import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/pray_time_widget.dart';
import 'package:islamdag/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: const NamazTime(),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => Future.delayed(
            Duration(seconds: 3),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            BlocProvider(
              create: (_) => ArticleBloc("news")..add(Fetch()),
              child: const CarouselBloc(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                  children: categories
                      .take(5)
                      .map((categoryItem) => Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: BlocProvider(
                              create: (_) =>
                                  ArticleBloc(categoryItem.values.first)
                                    ..add(Fetch()),
                              child: ArticlesBoxFeaturedList(
                                categoryName: categoryItem.keys.first,
                              ),
                            ),
                          ))
                      .toList()),
            )
          ]),
        )
      ],
    );
  }
}
