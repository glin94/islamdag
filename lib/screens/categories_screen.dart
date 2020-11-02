import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Article> articleList;

  const CategoriesScreen({Key key, this.articleList}) : super(key: key);
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBarView(
          children: categories
              .map<Widget>((e) => BlocProvider(
                  create: (_) => ArticleBloc(e.values.first)..add(Fetch()),
                  child: ArticlesList()))
              .toList()),
    );
  }
}
