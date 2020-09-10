import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class HtmlRendering extends StatelessWidget {
  final String content;

  const HtmlRendering({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        "html": Style(
          fontSize: FontSize.large,
        )
      },
      blacklistedElements: Platform.isIOS ? ["iframe"] : null,
      customRender: {
        "p": (rcontext, child, atribb, element) {
          return element.className.contains("rteright")
              ? SelectableText(
                  element.firstChild.text,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(height: 1.6),
                )
              : child;
        }
      },
    );
  }
}
