import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../utils.dart';

class MainScreen extends StatefulWidget {
  final BuildContext menuScreenContext;

  const MainScreen({Key key, this.menuScreenContext}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: _selectedIndex,
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(FlutterIcons.radio_mdi),
                onPressed: () => pushNewScreen(context,
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    screen: RadioScreen())),
            centerTitle: true,
            actions: [_selectedIndex == 4 ? AskButton() : Container()],
            bottom: _selectedIndex == 1
                ? TabBar(
                    isScrollable: true,
                    tabs: categories
                        .map<Tab>((e) => Tab(text: e.keys.first))
                        .toList())
                : null,
            flexibleSpace: CustomGradient(),
            elevation: 7,
            title: Image.asset(
              "assets/newlogo.png",
              width: MediaQuery.of(context).size.width / 2.3,
            ),
          ),
          body: PersistentTabView(
              onItemSelected: (i) => setState(() => _selectedIndex = i),
              controller: _controller,
              screens: listDrawer.map<Widget>((e) => e["screen"]).toList(),
              items: listDrawer
                  .map<PersistentBottomNavBarItem>(
                    (e) => PersistentBottomNavBarItem(
                        icon: Icon(e["icon"]),
                        title: e["text"],
                        activeColor: Colors.white,
                        inactiveColor: Colors.white.withOpacity(0.75)),
                  )
                  .toList(),
              confineInSafeArea: false,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              hideNavigationBar: _hideNavBar,
              popActionScreens: PopActionScreensType.once,
              decoration: NavBarDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.blue, Colors.green]),
                  colorBehindNavBar: Colors.indigo,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              popAllScreensOnTapOfSelectedTab: true,
              itemAnimationProperties: ItemAnimationProperties(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style9),
        ));
  }
}
