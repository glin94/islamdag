import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/article_card_item.dart';

class ArticlesList extends StatelessWidget {
  final String slug;
  const ArticlesList({
    Key key,
    this.slug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: Repository.get().getArticles(slug, 0),
          builder: (BuildContext c, AsyncSnapshot<List<Article>> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (c, i) =>
                          ArticleCardItem(article: snapshot.data[i]),
                    )
                  : Center(
                      child: Text(snapshot.error.toString()),
                    )),
    );
  }
}
