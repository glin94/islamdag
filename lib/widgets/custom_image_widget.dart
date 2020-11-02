import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class CustomImageWidget extends StatelessWidget {
  final List<dynamic> images;
  final double height;
  final double width;
  const CustomImageWidget({Key key, this.images, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isNotEmpty
        ? CachedNetworkImage(
            height: height,
            width: width,
            fit: BoxFit.cover,
            imageUrl: images[0]['src'],
            errorWidget: (c, s, d) => Image.asset(
                  "assets/splash_logo.png",
                  height: height,
                  width: width,
                ),
            placeholder: (c, s) => CustomShimmer(
                height: height,
                width: width,
                child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ))))
        : Image.asset(
            "assets/splash_logo.png",
            height: height,
            width: width,
          );
  }
}
