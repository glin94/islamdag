import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IslamDag',
      theme: ThemeData(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Colors.white)),
        accentColor: Color(0xFF003E57),
        canvasColor: Colors.white,
        primaryTextTheme:
            GoogleFonts.exo2TextTheme().apply(bodyColor: Colors.white),
        primaryColor: Colors.white,
        fontFamily: "Exo2",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
