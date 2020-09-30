import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/widgets.dart';

import './screens.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool isList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => isList = !isList),
          child: Icon(isList ? Icons.list : Icons.grid_on),
        ),
        backgroundColor: Colors.white,
        body: BlocProvider(
            create: (_) => ArticleBloc("lib")..add(Fetch()),
            child: BooksList(
              isList: isList,
            )));
  }
}

class BookListTile extends StatelessWidget {
  final Article book;
  const BookListTile({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (c) => BookDetailScreen(book))),
        child: Container(
          height: 150,
          child: Card(
            elevation: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                      tag: book.id,
                                      child: book.images != null
                                          ? CachedNetworkImage(
                                              height: 120,
                                              width: 80,
                                              fit: BoxFit.cover,
                                              imageUrl: book.images[0]['src'],
                                              placeholder: (c, s) => Container(
                                                  height: 120,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey[300],
                                                  )))
                                          : Image.asset(
                                              "assets/splash_logo.png",
                                              height: 120,
                                              width: 80,
                                            )))
                            ]))),
                Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(book.title,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                book.content == null ? "" : book.content,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookGridTile extends StatelessWidget {
  final Article book;
  const BookGridTile({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: book.id,
      child: Material(
        color: Colors.white,
        elevation: 15.0,
        shadowColor: Colors.blue.shade900,
        child: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (c) => BookDetailScreen(book))),
            child: book.images != null
                ? CachedNetworkImage(
                    imageUrl: book.images[0]["src"],
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/splash_logo.png",
                  )),
      ),
    );
  }
}
