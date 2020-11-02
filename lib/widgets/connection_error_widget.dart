import 'package:flutter/material.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';

class ConnectionErrorWidget extends StatelessWidget {
  const ConnectionErrorWidget({
    Key key,
    @required ArticleBloc articleBloc,
  })  : _articleBloc = articleBloc,
        super(key: key);

  final ArticleBloc _articleBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Возникли проблемы с загрузкой 😕",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            child: RaisedButton(
              onPressed: () => _articleBloc..add(Fetch()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 150.0, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Повторить",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
