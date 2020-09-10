import 'package:flutter/material.dart';
import 'package:islamdag/screens/ask_question_screen.dart';

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
