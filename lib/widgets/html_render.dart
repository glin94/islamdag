import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:islamdag/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlRendering extends StatelessWidget {
  final FontSize fontSize;
  final String content;

  const HtmlRendering(
      {Key key, @required this.content, this.fontSize = FontSize.large})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Html(
      onLinkTap: (link) => launch(link),
      data: content,
      style: {
        "html": Style(
          fontSize: fontSize,
        ),
        "a": Style(color: Theme.of(context).accentColor)
      },
      blacklistedElements: Platform.isIOS ? ["iframe"] : null,
      customRender: {
        "p": (pcontext, child, atribb, element) {
          return element.className.contains("rteright") &&
                  element.text.contains(RegExp(r'[ء-ي]')) &&
                  !element.text.contains(RegExp(r'[А-я]'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.blue[50],
                              Colors.green[50]
                            ])),
                    child: SelectableText(
                      element.firstChild.text,
                      textDirection: TextDirection.rtl,
                      toolbarOptions:
                          ToolbarOptions(copy: true, selectAll: true),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(height: 1.6),
                    ),
                  ))
              : element.innerHtml
                      .contains(RegExp('.*\.(gif|jpe?g|jpg|bmp|png)'))
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                          imageUrl:
                              url + element.firstChild.attributes['href']))
                  : child;
        },
      },
    );
  }
}
