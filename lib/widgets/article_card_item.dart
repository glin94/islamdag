import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/pages/article_details_page.dart';

class ArticleCardItem extends StatelessWidget {
  final Article article;

  const ArticleCardItem({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 95,
          ),
          elevation: 5,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (c) => ArticleDetailPage(
                              article: article,
                            ))),
                child: Hero(
                  tag: article.id,
                  child: CachedNetworkImage(
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/logo.png"),
                      placeholder: (context, url) =>
                          Image.asset("assets/logo.png"),
                      fit: BoxFit.cover,
                      imageUrl: article.images[0]["src"]),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          article.title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          article.date,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
