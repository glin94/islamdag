import 'package:flutter/material.dart';

import '../utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var _selectedIndex = 1;

class _HomeScreenState extends State<HomeScreen> {
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
                  listDrawer[_selectedIndex]["text"],
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
                  itemCount: listDrawer.length,
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
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() => _selectedIndex = 0);
                                      Navigator.pop(context);
                                    },

                                    //  Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (c) => RadioScreen())),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
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
                            color: listDrawer.indexOf(listDrawer[i]) ==
                                    _selectedIndex
                                ? Theme.of(context).accentColor
                                : null,
                            child: ListTile(
                              leading: Icon(
                                listDrawer[i]["icon"],
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = i;
                                });
                                Navigator.pop(context);
                              },
                              title: Text(
                                listDrawer[i]["text"],
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
            body: listDrawer[_selectedIndex]["body"]));
  }
}
