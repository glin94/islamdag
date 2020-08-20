import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';

class BookDetailPage extends StatelessWidget {
  final Article book;

  BookDetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      elevation: .5,
      title: Text('Библиотека'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        )
      ],
    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.blue.shade900,
              child: CachedNetworkImage(
                imageUrl: book.images[0]['src'],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );

    ///detail top right
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
            Icon(Icons.remove_red_eye),
            SizedBox(width: 10),
            text(book.totalCount, color: Colors.black38, size: 14),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        MaterialButton(
          onPressed: () {},
          minWidth: 160.0,
          color: Colors.blue,
          child: text('Скачать', color: Colors.white, size: 14, isBold: true),
        ),
      ],
    );

    final topContent = Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Expanded(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      book.content,
                      style: TextStyle(fontSize: 16.0, height: 1.5),
                    ),
                  ],
                ))));

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.black87,
          num size = 14,
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
