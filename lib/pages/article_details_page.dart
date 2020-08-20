import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/carousel_images.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Новости"),
        ),
        body: Scrollbar(
          child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  Text(article.title,
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
                  HtmlWidget(
                    article.content,
                    enableCaching: true,
                    webView: true,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 16),
                  ),
                  // Html(
                  //   data: article.content,
                  //   onLinkTap: (url) {
                  //     // open url in a webview
                  //   },
                  //   style: {
                  //     "p": Style(
                  //       padding: EdgeInsets.zero,
                  //       fontSize: FontSize(16),
                  //     ),
                  //   },
                  //   onImageTap: (src) {
                  //     // Display the image in large form.
                  //   },
                  // )
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 100,
                  // ),
                ],
              ),
            ),
          ]),
        ));
  }
}
