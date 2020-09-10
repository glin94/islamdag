import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/carousel_images.dart';
import 'package:islamdag/widgets/html_render.dart';
import 'package:islamdag/widgets/share_button.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            ShareButton(
              item: article,
            )
          ],
          centerTitle: true,
          title: Text("Новости"),
        ),
        body: Scrollbar(
            child:
                ListView(physics: ClampingScrollPhysics(), children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          GestureDetector(
            onTap: () async {
              print(await Repository.get().getPrayTime());
            },
            child: CarouselImages(
              images: article.images,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: <Widget>[
                  Text(article.title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        article.date,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            article.totalCount,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 100,
                          ),
                          Icon(Icons.remove_red_eye, color: Colors.blue)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),
                  HtmlRendering(content: article.content)
                ],
              ))
        ])));
  }
}
