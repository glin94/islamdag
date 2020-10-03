import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/article_bloc/simple_bloc_observer.dart';
import 'screens/screens.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of  application.
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
        canvasColor: Color(0xFF0084CF),
        primaryTextTheme:
            GoogleFonts.exo2TextTheme().apply(bodyColor: Colors.white),
        primaryColor: Color(0xFF00BBF5),
        fontFamily: "Exo2",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
