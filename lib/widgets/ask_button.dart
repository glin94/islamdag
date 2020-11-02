import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/screens/screens.dart';

class AskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Задать вопрос",
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (c) => AskQuestionScreen())),
      icon: const Icon(FlutterIcons.lead_pencil_mco),
    );
  }
}
