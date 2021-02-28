import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/widgets.dart';

class FatawaDetailsPage extends StatelessWidget {
  final Article article;

  const FatawaDetailsPage({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          ShareButton(item: article),
        ],
        flexibleSpace: CustomGradient(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Вопрос:",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(article.voprosi == null ? article.title : article.voprosi,
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Divider(
                    height: 2,
                  ),
                ),
                article.content.contains("ОТВЕТ")
                    ? Container()
                    : Text(
                        "Ответ:",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: HtmlRendering(
              content: article.content,
            ),
          )
        ]),
      ),
    );
  }
}
