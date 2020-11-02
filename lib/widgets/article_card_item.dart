import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ArticleCardItem extends StatelessWidget {
  final Article article;

  const ArticleCardItem({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 95,
          ),
          elevation: 5,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GestureDetector(
                  onTap: () => pushNewScreen(context,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                      withNavBar: false,
                      screen: ArticleDetailScreen(
                        article: article,
                      )),
                  child: CustomImageWidget(images: article.images)),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Text(
                      article.title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          )),
    );
  }
}
