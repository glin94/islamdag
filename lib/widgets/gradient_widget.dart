import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GradientWidget extends StatelessWidget {
  final Widget child;

  const GradientWidget({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return ui.Gradient.linear(
            const Offset(24.0, 24.0),
            const Offset(24.0, 4.0),
            [
              Colors.blue,
              Colors.green,
            ],
          );
        },
        child: child);
  }
}
