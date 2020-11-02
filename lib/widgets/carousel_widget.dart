import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';

import 'widgets.dart';

class CarouselArticlesWidget extends StatefulWidget {
  final List<Article> articles;

  const CarouselArticlesWidget({
    Key key,
    @required this.articles,
  }) : super(key: key);

  @override
  _CarouselArticlesWidgetState createState() => _CarouselArticlesWidgetState();
}

class _CarouselArticlesWidgetState extends State<CarouselArticlesWidget> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.articles
                .sublist(0, 7)
                .map<Widget>((article) => ArticleBoxFeatured(article: article))
                .toList(),
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 3 + 10,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.articles.sublist(0, 7).map((url) {
              int index = widget.articles.sublist(0, 7).indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.blue
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList()),
      ],
    );
  }
}
