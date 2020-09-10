import 'dart:io';

import 'package:islamdag/models/article.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../utils.dart';

Dio dio = new Dio();

List<Article> parseArticles(var responseBody) {
  var parsed = responseBody["nodes"].cast<Map<String, dynamic>>();
  return parsed.map<Article>((json) => Article.fromJson(json["node"])).toList();
}

Article parseArticle(String responseBody) {
  final parsed = json.decode(responseBody)["nodes"];
  return Article.fromJson(parsed);
}

Future<Map<String, dynamic>> fetchPrayTime() async {
  String apiUrl = "$url/json/namaz.json";
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

Future<bool> sendQuestion(String name, String question, String email) async {
  var isSend = false;
  final response = await dio.post("$url/json/mail.php",
      data: {"name": name, "question": question, "email": email});
  if (response.statusCode == 200) {
    isSend = true;
  } else {
    isSend = false;
    throw new Exception("Failed to send");
  }
  return isSend;
}

Future<List<Article>> fetchArticles(String slug, int page) async {
  String apiUrl = '$url/json/$slug';
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
