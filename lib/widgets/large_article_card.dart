import 'package:flutter/material.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:islamdag/utils.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LargeArticleCard extends StatelessWidget {
  final Article article;

  const LargeArticleCard({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
          onTap: () => pushNewScreen(context,
              screen: ArticleDetailScreen(article: article),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryWidget(
                            article: article,
                          ),
                          ArticleViewsCount(article: article)
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CustomImageWidget(
                          images: article.images,
                        )),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(article.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              HtmlRendering(
                  content: article.content
                      .substring(0, article.content.indexOf(".") + 1)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Text(
                    parseDateAgo(article.date),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  alignment: Alignment.centerRight,
                ),
              )
            ],
          )),
    );
  }
}
