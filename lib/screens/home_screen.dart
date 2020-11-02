import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/pray_time_widget.dart';
import 'package:islamdag/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        child: NamazTime(),
      ),
      BlocProvider(
        create: (_) => ArticleBloc("news")..add(Fetch()),
        child: CarouselBloc(),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
            children: categories
                .take(5)
                .map((categoryItem) => Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: BlocProvider(
                        create: (_) => ArticleBloc(categoryItem.values.first)
                          ..add(Fetch()),
                        child: ArticlesBoxFeaturedList(
                          categoryName: categoryItem.keys.first,
                        ),
                      ),
                    ))
                .toList()),
      )
    ]));
  }
}
