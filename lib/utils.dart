import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:islamdag/models/area.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;

import 'screens/screens.dart';

const String url = 'http://islamdag.ru';
var listDrawer = [
  {"text": " Главная", "icon": AntDesign.home, "screen": const HomeScreen()},
  {"text": "Статьи", "icon": AntDesign.profile, "screen": CategoriesScreen()},
  {
    "text": "Видеотека",
    "icon": FlutterIcons.social_youtube_sli,
    "screen": VideosScreen()
  },
  {"text": "Библиотека", "icon": AntDesign.book, "screen": LibraryScreen()},
  {
    "text": "Фетвы",
    "icon": AntDesign.questioncircleo,
    "screen": FatawasScreen()
  }
];

Area defaultArea = Area(
  id: 185733,
  districtCode: "0",
  name: "Махачкала",
  selected: true,
  type: "г.",
);
const categories = [
  {"Последние": "articles"},
  {"Новости": "news"},
  {"Аналитика": "articles/analitika"},
  {"Вероучение": "articles/verouchenie"},
  {"История": "articles/istoriya"},
  {"Личности": "articles/lichnosti"},
  {"Мусульманка": "articles/musulmanka"},
  {"Все об Исламе": "articles/vseobislame"},
  {"Мы в Исламе": "articles/v-islame"},
  {"Актуальное интервью": "articles/intervy"},
  {"Здоровье": "articles/health"},
];

void initTimeLang() {
  timeago.setLocaleMessages("ru", timeago.RuMessages());
  var rus = intl.initializeDateFormatting("ru", null);
  Future.wait([rus]);
}

String parseDateAgo(String s) {
  String month = s.split(",").removeAt(1).split(" ")[1];
  String str = s
      .replaceAll(month, getMonthsNumber(month))
      .split(",")
      .sublist(1, 3)
      .join(" ");
  final time = str.split(" ").where((e) => e.isNotEmpty && e != "-").join("/");
  DateTime d = DateFormat('M/dd/yyyy/hh:mm').parse(time);
  return timeago.format(
    d,
    locale: "ru",
    allowFromNow: true,
  );
}

getMonthsNumber(String month) {
  switch (month) {
    case "Январь":
      return "1";
      break;
    case "Февраль":
      return "2";
      break;
    case "Март":
      return "3";
      break;
    case "Апрель":
      return "4";
      break;
    case "Май":
      return "5";
      break;
    case "Июнь":
      return "6";
      break;
    case "Июль":
      return "7";
      break;
    case "Август":
      return "8";
      break;
    case "Сентябрь":
      return "9";
      break;
    case "Октябрь":
      return "10";
      break;
    case "Ноябрь":
      return "11";
      break;
    case "Декабрь":
      return "12";
      break;
    default:
  }
}

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
