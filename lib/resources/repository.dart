import 'dart:async';

import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/api_provider.dart';

class Repository {
  static final Repository _repo = Repository._internal();
  static Repository get() {
    return _repo;
  }

  Repository._internal();

  Future<List<Article>> getArticles(String slug, int page) async {
    return await fetchArticles(slug, page);
  }

  Future<List<Map<String, dynamic>>> getPrayTime() async {
    final prayTime = await fetchPrayTime();
    List<Map<String, dynamic>> list = List();
    prayTime.forEach((key, value) {
      list.add(value);
    });
    return list;
  }
}
