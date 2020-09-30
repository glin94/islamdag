import 'package:flutter/material.dart';
import 'package:islamdag/screens/screens.dart';

class FatawaFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (c) => AskQuestionScreen())),
      child: Icon(Icons.question_answer),
    );
  }
}
