import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:islamdag/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlRendering extends StatelessWidget {
  final String content;

  const HtmlRendering({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Html(
      onLinkTap: (link) => launch(link),
      data: content,
      style: {
        "html": Style(
          fontSize: FontSize.large,
        ),
        "a": Style(color: Theme.of(context).accentColor)
      },
      blacklistedElements: Platform.isIOS ? ["iframe"] : null,
      customRender: {
        "p": (pcontext, child, atribb, element) {
          return element.className.contains("rteright") &&
                  element.text.contains(RegExp(r'[ء-ي]')) &&
                  !element.text.contains(RegExp(r'[А-я]'))
              ? SelectableText(
                  element.firstChild.text,
                  textDirection: TextDirection.rtl,
                  toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(height: 1.6),
                )
              : element.innerHtml
                      .contains(RegExp('.*\.(gif|jpe?g|jpg|bmp|png)'))
                  ? CachedNetworkImage(
                      imageUrl: url + element.firstChild.attributes['href'])
                  : child;
        },
      },
    );
  }
}
