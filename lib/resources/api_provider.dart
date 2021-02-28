import 'package:islamdag/models/area.dart';
import 'package:islamdag/models/article.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../utils.dart';

const citysUrl = 'https://app.muftiyatrd.ru/api/cities';
const areasUrl = 'https://app.muftiyatrd.ru/api/areas';

Dio dio = new Dio();

List<Article> parseArticles(var responseBody) {
  var parsed = responseBody["nodes"].cast<Map<String, dynamic>>();
  return parsed.map<Article>((json) => Article.fromJson(json["node"])).toList();
}

Article parseArticle(String responseBody) {
  final parsed = json.decode(responseBody)["nodes"];
  return Article.fromJson(parsed);
}

Future<List<dynamic>> fetchPrayTime(int regionId) async {
  String apiUrl =
      "https://app.muftiyatrd.ru/api/ruznama?city=$regionId&year=${DateTime.now().year}&month=${DateTime.now().month}";
  final response = await dio.get(apiUrl);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.data["array"].toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pray time');
  }
}

Future<List<Area>> fetchAreas() async {
  final responseCity = await dio.get(citysUrl);
  final responseAreas = await dio.get(areasUrl);
  var list = List();
  if (responseCity.statusCode == 200 && responseAreas.statusCode == 200) {
    list = responseCity.data["array"].toList() +
        responseAreas.data["array"].toList();
    return list.map((json) => Area.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pray region');
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
