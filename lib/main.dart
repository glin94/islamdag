import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamdag/screens/categories_screen.dart';
import 'package:islamdag/screens/fatawas_screen.dart';
import 'package:islamdag/screens/library_screen.dart';
import 'package:islamdag/screens/news_screen.dart';
import 'package:islamdag/screens/pray_time_screen.dart';
import 'package:islamdag/screens/videos_screen.dart';
import 'package:islamdag/utils.dart';

import 'bloc/article_bloc/simple_bloc_observer.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IslamDag',
      theme: ThemeData(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Colors.white)),
        accentColor: Color(0xFF003E57),
        canvasColor: Color(0xFF0084CF),
        primaryTextTheme:
            GoogleFonts.exo2TextTheme().apply(bodyColor: Colors.white),
        primaryColor: Color(0xFF00BBF5),
        fontFamily: "Exo2",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var _selectedIndex = 1;
var _listDrawer = [
  {"text": "Новости", "icon": Icons.new_releases, "body": Container()},
  {"text": "Новости", "icon": Icons.new_releases, "body": NewsListScreen()},
  {"text": "Статьи", "icon": Icons.menu, "body": CategoriesScreen()},
  {"text": "Время молитвы", "icon": Icons.timer, "body": PrayTimeScreen()},
  {"text": "Видеотека", "icon": Icons.tv, "body": VideosScreen()},
  {"text": "Библиотека", "icon": Icons.library_books, "body": LibraryScreen()},
  {"text": "Фетвы", "icon": Icons.question_answer, "body": FatawasScreen()}
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: categories.length,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Builder(
                  builder: (context) => IconButton(
                      icon: Image(
                          image: new AssetImage("assets/menu_burger.png"),
                          height: MediaQuery.of(context).size.height / 23,
                          color: null,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center),
                      onPressed: () => Scaffold.of(context).openDrawer())),
              bottom: _selectedIndex == 2
                  ? TabBar(
                      isScrollable: true,
                      tabs: categories
                          .map<Tab>((e) => Tab(text: e.keys.first))
                          .toList())
                  : null,
              centerTitle: true,
              title: Container(
                child: Text(
                  _listDrawer[_selectedIndex]["text"],
                ),
              ),
            ),
            drawer: Drawer(
              child: ListTileTheme(
                selectedColor: Theme.of(context).accentColor,
                style: ListTileStyle.drawer,
                textColor: Colors.white,
                iconColor: Colors.white,
                child: ListView.separated(
                  separatorBuilder: (c, i) => i == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 1,
                            color: Colors.white,
                          ),
                        ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _listDrawer.length,
                  itemBuilder: (c, i) {
                    return i == 0
                        ? DrawerHeader(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  bottom:
                                      MediaQuery.of(context).size.height / 25,
                                  left: MediaQuery.of(context).size.width / 10,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Image.asset("assets/header_logo.png"),
                                ),
                                Positioned(
                                  bottom: 5,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                12,
                                      ),
                                      Text(
                                        "Радио",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  // child: ListTile(
                                  //   leading: Icon(
                                  //     Icons.play_arrow,
                                  //   ),
                                  //   onTap: () {
                                  //     setState(() {});
                                  //     Navigator.pop(context);
                                  //   },
                                  //   title: Text(
                                  //     "Радио",
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .headline6
                                  //         .copyWith(color: Colors.black),
                                  //   ),
                                  // ),
                                )
                              ],
                            ),

                            //     Padding(
                            //       padding: EdgeInsets.only(bottom: 50),
                            //       child: Image.asset("assets/header_logo.png"),
                            //     ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    alignment: Alignment.bottomCenter,
                                    image: AssetImage(
                                      "assets/header_radio_bg.png",
                                    ))))
                        : Container(
                            color: _listDrawer.indexOf(_listDrawer[i]) ==
                                    _selectedIndex
                                ? Theme.of(context).accentColor
                                : null,
                            child: ListTile(
                              leading: Icon(
                                _listDrawer[i]["icon"],
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = i;
                                });
                                Navigator.pop(context);
                              },
                              title: Text(
                                _listDrawer[i]["text"],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            body: _listDrawer[_selectedIndex]["body"]));
  }
}
