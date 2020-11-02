import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'widgets.dart';

class ArticleBoxFeatured extends StatelessWidget {
  final Article article;

  const ArticleBoxFeatured({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewScreen(context,
          withNavBar: false,
          screen: ArticleDetailScreen(
            article: article,
          )),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 3,
            maxHeight: MediaQuery.of(context).size.height / 3 + 10,
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Hero(
                    tag: article.id,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CustomImageWidget(
                          images: article.images,
                        )),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1,
                  margin: EdgeInsets.all(10),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height / 3 - 180,
              right: 20,
              child: Container(
                alignment: Alignment.bottomRight,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              child: Text(article.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.bold))),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(
                                            FlutterIcons.calendar_ant,
                                            color: Colors.black45,
                                            size: 12.0,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            article.date
                                                .split(",")
                                                .sublist(1)
                                                .join(','),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                      CategoryWidget(article: article),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
