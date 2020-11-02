import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/models/article.dart';
import 'package:share/share.dart';

import '../utils.dart';

class ShareButton extends StatelessWidget {
  final Article item;

  const ShareButton({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(FlutterIcons.share_mco),
        onPressed: () => Share.share(
            "${item.title}\n${item.path.contains("http") ? item.path : url + item.path}"));
  }
}
