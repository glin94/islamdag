import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/floating_button.dart';

class FatawaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FatawaFloatingButton(),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: Repository.get().getArticles("fatawa", 0),
            builder: (BuildContext c, AsyncSnapshot<List<Article>> snapshot) {
              return snapshot.hasData
                  ? ListView.separated(
                      itemBuilder: (c, i) =>
                          FatawaItem(article: snapshot.data[i]),
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                        height: 1,
                        color: Theme.of(context).canvasColor,
                      ),
                    )
                  : Center(child: Text(snapshot.error));
            }));
  }
}

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
                    artcile: article,
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
            Text(article.voprosi, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
    );
  }
}

class FatawaDetailsPage extends StatelessWidget {
  final Article artcile;

  const FatawaDetailsPage({Key key, this.artcile}) : super(key: key);
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
                  Text(artcile.voprosi,
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
                  HtmlWidget(
                    artcile.content,
                    enableCaching: true,
                    webView: true,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 16),
                  ),
                ]),
          ),
        ));
  }
}
