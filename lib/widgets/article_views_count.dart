import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/widgets/widgets.dart';

class ArticleViewsCount extends StatelessWidget {
  const ArticleViewsCount({
    Key key,
    @required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GradientWidget(
          child: Text(
            article.totalCount,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.blue,
                ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 100,
        ),
        GradientWidget(child: Icon(FlutterIcons.eye_ent))
      ],
    );
  }
}
