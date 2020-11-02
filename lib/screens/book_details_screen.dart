import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/widgets.dart';

class BookDetailScreen extends StatelessWidget {
  final Article book;

  BookDetailScreen(this.book);

  @override
  Widget build(BuildContext context) {
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.id,
            child: Material(
                elevation: 15.0,
                color: Colors.white,
                shadowColor: Colors.blue.shade900,
                child: CustomImageWidget(
                  images: book.images,
                )),
          ),
        ),
      ],
    );

    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.height / 3,
          child: text(book.title,
              color: Colors.white,
              size: 18,
              isBold: true,
              padding: EdgeInsets.only(top: 16.0)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Row(
          children: <Widget>[
            Icon(FlutterIcons.eye_ent),
            SizedBox(width: 10),
            text(book.totalCount, color: Colors.black38, size: 14),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        book.url != null
            ? MaterialButton(
                onPressed: () {
                  print(book.url);
                  launchURL(book.url, context);
                },
                minWidth: 160.0,
                color: Colors.blue,
                child: text('Скачать',
                    color: Colors.white, size: 16, isBold: true),
              )
            : Container(),
      ],
    );
    final topContent = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight)
        ],
      ),
    );

    final bottomContent = Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16),
        child: Container(
          child: SelectableText(
            book.content,
            style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.white),
          ),
        ));

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.green])),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  snap: true,
                  floating: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[ShareButton(item: book)],
                ),
                SliverList(
                  delegate:
                      SliverChildListDelegate([topContent, bottomContent]),
                )
              ],
            )),
      ],
    );
  }

  text(String data,
          {Color color = Colors.black87,
          num size = 16,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
}
