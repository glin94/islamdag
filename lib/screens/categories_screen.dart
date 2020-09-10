import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/articles_list.dart';

class CategoriesScreen extends StatelessWidget {
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
