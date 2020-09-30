import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/screens.dart';

const String url = 'http://islamdag.ru';
var listDrawer = [
  {
    "text": "Радио",
    "icon": FlutterIcons.newspaper_minus_mco,
    "body": RadioScreen()
  },
  {
    "text": "Новости",
    "icon": FlutterIcons.newspaper_mco,
    "body": NewsListScreen()
  },
  {
    "text": "Статьи",
    "icon": FlutterIcons.post_outline_mco,
    "body": CategoriesScreen()
  },
  {
    "text": "Время молитвы",
    "icon": FlutterIcons.clock_faw5,
    "body": PrayTimeScreen()
  },
  {
    "text": "Видеотека",
    "icon": FlutterIcons.library_video_mco,
    "body": VideosScreen()
  },
  {
    "text": "Библиотека",
    "icon": FlutterIcons.library_mco,
    "body": LibraryScreen()
  },
  {"text": "Фетвы", "icon": FlutterIcons.question_oct, "body": FatawasScreen()}
];

const categories = [
  {"Все об Исламе": "articles/vseobislame"},
  {"Вероучение": "articles/verouchenie"},
  {"История": "articles/istoriya"},
  {"Личности": "articles/lichnosti"},
  {"Аналитика": "articles/analitika"},
  {"Мусульманка": "articles/musulmanka"},
  {"Мы в Исламе": "articles/v-islame"},
  {"Актуальное интервью": "articles/intervy"},
  {"На родном": "articles/narodnom"},
];

String getMonthsName(int number) {
  switch (number) {
    case 1:
      return "Январь";
      break;
    case 2:
      return "Февраль";
      break;
    case 3:
      return "Март";
      break;
    case 4:
      return "Апрель";
      break;
    case 5:
      return "Май";
      break;
    case 6:
      return "Июнь";
      break;
    case 7:
      return "Июль";
      break;
    case 8:
      return "Август";
      break;
    case 9:
      return "Сентябрь";
      break;
    case 10:
      return "Октябрь";
      break;
    case 11:
      return "Ноябрь";
      break;
    case 12:
      return "Декабрь";
    default:
      return "Месяц не определен";
  }
}

launchURL(String url, BuildContext context) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Недопустимая ссылка")));
  }
}

converter(String html) {
  var unescape = new HtmlUnescape();
  return unescape.convert(html);
}
