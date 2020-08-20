import 'package:flutter/material.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/articles_list.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: categories
            .map<Widget>((e) => ArticlesList(
                  slug: e.values.first,
                ))
            .toList());
  }
}
