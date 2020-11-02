import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final double height;
  const CustomGradient({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blue, Colors.green])));
  }
}
