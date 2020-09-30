import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/screens.dart';

import '../utils.dart';

class FatawaItem extends StatelessWidget {
  final Article article;

  const FatawaItem({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => FatawaDetailsPage(
                    article: article,
                  ))),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              article.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).accentColor),
            ),
            Text(article.voprosi == null ? "" : converter(article.voprosi),
                style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
    );
  }
}
