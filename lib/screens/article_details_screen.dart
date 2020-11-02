import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/article_views_count.dart';
import 'package:islamdag/widgets/widgets.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
            stretchTriggerOffset: 50,
            onStretchTrigger: () {
              return;
            },
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: CarouselImages(
                images: article.images,
              ),
            ),
            actions: [
              // IconButton(
              //     icon: Icon(FlutterIcons.format_text_mco),
              //     onPressed: () {
              //       showModalBottomSheet(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16.0),
              //           ),
              //           clipBehavior: Clip.antiAlias,
              //           context: context,
              //           builder: (c) => ModalSheet());
              //     }),
              ShareButton(
                item: article,
              )
            ]),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(article.title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GradientWidget(
                          child: Text(
                        article.date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                      ArticleViewsCount(article: article)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                HtmlRendering(content: article.content)
              ],
            ),
          )
        ]))
      ],
    )));
  }
}

class ModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Flexible(
          child: Text(
            "Размер текста",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Opacity(
            opacity: 0.0,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: null,
            )),
      ]),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
            children: List.generate(5, (int index) => index)
                .map((e) => Container(
                      child: Icon(Icons.text_format, size: 40),
                    ))
                .toList()),
      )
    ]));
  }
}
