import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const CustomShimmer({Key key, this.height, this.width, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
            child: child,
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[300],
            )),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100]);
  }
}

class CardBoxShimmer extends StatelessWidget {
  final String categoryName;

  const CardBoxShimmer({Key key, @required this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      categoryName.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.white,
                    loop: 3,
                    child: Text(categoryName,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      loop: 3,
                      child: Text("все",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )))
                ],
              ),
            )
          : Container(),
      Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[Colors.white, Colors.green]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: MediaQuery.of(context).size.height / 3,
                  ))))
    ]);
  }
}

class NamazWidgetShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.white, Colors.green])),
        ));
  }
}

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.white, Colors.green]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: MediaQuery.of(context).size.height / 3.5 + 10,
            )),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.filled(7, 0).map((url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList())
    ]);
  }
}
