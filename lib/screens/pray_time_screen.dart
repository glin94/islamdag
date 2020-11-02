import 'package:flutter/material.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/widgets.dart';

import '../utils.dart';

class PrayTimeScreen extends StatefulWidget {
  const PrayTimeScreen({Key key}) : super(key: key);

  @override
  _PrayTimeScreenState createState() => _PrayTimeScreenState();
}

class _PrayTimeScreenState extends State<PrayTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            flexibleSpace: CustomGradient(),
            elevation: 0,
            title:
                Text("Время намаза на ${getMonthsName(DateTime.now().month)}")),
        SliverAppBar(
            pinned: true,
            toolbarHeight: MediaQuery.of(context).size.height / 16,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              title: DefaultTextStyle(
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Дата",
                    ),
                    Text(
                      "Фад.",
                    ),
                    Text(
                      "Вос.",
                    ),
                    Text(
                      "Зухр",
                    ),
                    Text(
                      "Аср",
                    ),
                    Text(
                      "Маг.",
                    ),
                    Text(
                      "Иша",
                    ),
                  ],
                ),
              ),
            )),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            color: Colors.white,
            child: FutureBuilder(
                future: Repository.get().getPrayTime(),
                builder: (BuildContext c,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    final dayofYear = DateTime.now()
                        .difference(DateTime(DateTime.now().year, 1, 1))
                        .inDays;
                    var firstDayThisMonth = new DateTime(
                        DateTime.now().year, DateTime.now().month, 1);
                    var firstDayThisMonthYear = firstDayThisMonth
                        .difference(DateTime(DateTime.now().year, 1, 2))
                        .inDays;

                    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
                        firstDayThisMonth.month + 1, firstDayThisMonth.day);
                    final prayTime = snapshot.data;
                    final list = prayTime
                        .getRange(
                            firstDayThisMonthYear,
                            firstDayThisMonthYear +
                                firstDayNextMonth
                                    .difference(firstDayThisMonth)
                                    .inDays)
                        .toList();
                    return Container(
                        padding: EdgeInsets.all(8),
                        child: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          child: Column(
                              children: list
                                  .map<DefaultTextStyle>((entry) =>
                                      DefaultTextStyle(
                                        style: TextStyle(
                                            fontFamily: "Exo2",
                                            color: list.indexOf(entry) + 1 ==
                                                    DateTime.now().day
                                                ? Colors.red
                                                : Colors.black
                                                    .withOpacity(0.6)
                                                    .withOpacity(0.7)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    list.indexOf(entry) % 2 == 0
                                                        ? Colors.blue
                                                            .withOpacity(0.3)
                                                        : Colors.grey
                                                            .withOpacity(0.3),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "${list.indexOf(entry) + 1}",
                                                    style: TextStyle(
                                                        fontFamily: "Exo2",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: list.indexOf(
                                                                        entry) +
                                                                    1 ==
                                                                DateTime.now()
                                                                    .day
                                                            ? Colors.red
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.7)),
                                                  ),
                                                  Text(
                                                    entry["namaz_1"],
                                                  ),
                                                  Text(
                                                    entry["voshod"],
                                                  ),
                                                  Text(
                                                    entry["namaz_2"],
                                                  ),
                                                  Text(
                                                    entry["namaz_3"],
                                                  ),
                                                  Text(
                                                    entry["namaz_4"],
                                                  ),
                                                  Text(
                                                    entry["namaz_5"],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        ));
                  } else
                    return Center(child: CircularProgressIndicator());
                }),
          ),
        ]))
      ],
    ));
  }
}
