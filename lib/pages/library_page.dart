import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/pages/book_detail_page.dart';
import 'package:islamdag/resources/repository.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: FutureBuilder(
          future: Repository.get().getArticles("lib", 0),
          builder: (BuildContext c, AsyncSnapshot<List<Article>> snapshot) =>
              snapshot.hasData
                  ? CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.all(16.0),
                          sliver: SliverGrid.count(
                            childAspectRatio: 2 / 3,
                            crossAxisCount: 3,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            children: snapshot.data
                                .map<Widget>((book) => Hero(
                                      tag: book.title,
                                      child: Material(
                                        elevation: 15.0,
                                        shadowColor: Colors.blue.shade900,
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      BookDetailPage(book))),
                                          child: CachedNetworkImage(
                                            imageUrl: book.images[0]["src"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Text(snapshot.error.toString()),
                    )),
    );
  }
}
