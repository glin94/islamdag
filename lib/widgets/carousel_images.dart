import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/widgets/widgets.dart';

class CarouselImages extends StatefulWidget {
  final List images;

  const CarouselImages({Key key, this.images}) : super(key: key);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  @override
  Widget build(BuildContext context) {
    return widget.images.length > 1
        ? Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Carousel(
                boxFit: BoxFit.cover,
                images: widget.images
                    .map<Widget>(
                      (e) => CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                                "assets/splash_logo.png",
                              ),
                          placeholder: (context, url) => Image.asset(
                                "assets/splash_logo.png",
                              ),
                          imageUrl: widget.images[widget.images.indexOf(e)]
                              ['src'],
                          fit: BoxFit.cover),
                    )
                    .toList(),
                dotIncreasedColor: Colors.blue,
                autoplay: false,
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.white,
                indicatorBgPadding: 10.0,
                dotBgColor: Colors.transparent),
          )
        : CustomImageWidget(
            images: widget.images,
          );
  }
}
