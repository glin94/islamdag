import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

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
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/logo.png"),
                          placeholder: (context, url) =>
                              Image.asset("assets/logo.png"),
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
        : CachedNetworkImage(
            errorWidget: (context, url, error) =>
                Image.asset("assets/logo.png"),
            placeholder: (context, url) => Image.asset("assets/logo.png"),
            imageUrl: widget.images[0]['src'],
            fit: BoxFit.cover);
    // Stack(children: <Widget>[
    //   CarouselSlider.builder(
    //     itemCount: widget.images.length,
    //     itemBuilder: (c, i) => CachedNetworkImage(
    //         imageUrl: widget.images[i]['src'], fit: BoxFit.contain),
    //     options: CarouselOptions(

    //       onPageChanged: (index, reason) {
    //       setState(() {
    //         _current = index;
    //       });
    //     }),
    //   ),
    //   Positioned(
    //     bottom: 10,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: widget.images.map((url) {
    //         int index = widget.images.indexOf(url);
    //         return Container(
    //           width: 8.0,
    //           height: 8.0,
    //           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: _current == index
    //                 ? Color.fromRGBO(0, 0, 0, 0.9)
    //                 : Color.fromRGBO(0, 0, 0, 0.4),
    //           ),
    //         );
    //       }).toList(),
    //     ),
    //   )
    // ]);
  }
}
