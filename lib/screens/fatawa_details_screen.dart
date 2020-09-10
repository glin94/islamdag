import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/html_render.dart';

class FatawaDetailsPage extends StatelessWidget {
  final Article article;

  const FatawaDetailsPage({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Фетвы")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Вопрос:",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      article.voprosi == null ? article.title : article.voprosi,
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ответ:",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  HtmlRendering(
                    content: article.content,
                  )
                ]),
          ),
        ));
  }
}
