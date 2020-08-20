import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/pages/article_details_page.dart';
import 'package:islamdag/widgets/articles_list.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArticlesList(
      slug: "news",
    );
  }
}
