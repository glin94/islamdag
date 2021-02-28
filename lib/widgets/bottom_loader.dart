import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
