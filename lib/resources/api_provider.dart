import 'dart:io';

import 'package:flutter/foundation.dart' as prefix0;
import 'package:html_unescape/html_unescape.dart';
import 'package:islamdag/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

final String url = 'http://islamdag.ru/json';
Dio dio = new Dio();

String htmlEnescape(String s) {
  var unescape = new HtmlUnescape();
  var text = unescape.convert(s);
  return text;
}

List<Article> parseArticles(var responseBody) {
  var parsed = responseBody["nodes"].cast<Map<String, dynamic>>();
  return parsed.map<Article>((json) => Article.fromJson(json["node"])).toList();
}

Article parseArticle(String responseBody) {
  final parsed = json.decode(responseBody)["nodes"];
  return Article.fromJson(parsed);
}

Future<Map<String, dynamic>> fetchPrayTime() async {
  String apiUrl = "$url/namaz.json";
  final response = await dio.get(apiUrl);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.data;
  } else if (response.statusCode == 404) {
    throw HttpException("Файл не найден");
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pray time');
  }
}

Future<List<Article>> fetchArticles(String slug, int page) async {
  String apiUrl = '$url/$slug';
  final response = await dio.get(apiUrl, queryParameters: {"page": page});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseArticles(response.data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load articles');
  }
}
