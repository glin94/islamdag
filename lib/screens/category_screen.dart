import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          flexibleSpace: CustomGradient(),
        ),
        body: BlocProvider(
          create: (_) => ArticleBloc(
              categories.firstWhere((e) => e.containsValue(e[name]))[name])
            ..add(Fetch()),
          child: SingleChildScrollView(
            child: ArticlesBoxFeaturedList(
              categoryName: "",
            ),
          ),
        ));
  }
}
