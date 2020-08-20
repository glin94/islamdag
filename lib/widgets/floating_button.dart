import 'package:flutter/material.dart';
import 'package:islamdag/pages/ask_question_page.dart';
import 'package:islamdag/pages/fatawa_list_page.dart';

class FatawaFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (c) => AskQuestionPage())),
      child: Icon(Icons.question_answer),
    );
  }
}
