import 'package:flutter/material.dart';
import 'package:islamdag/resources/repository.dart';

import '../utils.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Repository.get().getPrayTime(),
        builder: (BuildContext c,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final dayofYear = DateTime.now()
                .difference(DateTime(DateTime.now().year, 1, 1))
                .inDays;
            var firstDayThisMonth =
                new DateTime(DateTime.now().year, DateTime.now().month, 1);
            var firstDayThisMonthYear = firstDayThisMonth
                .difference(DateTime(DateTime.now().year, 1, 1))
                .inDays;

            var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
                firstDayThisMonth.month + 1, firstDayThisMonth.day);
            final prayTime = snapshot.data;
            final list = prayTime
                .getRange(
                    firstDayThisMonthYear,
                    firstDayThisMonthYear +
                        firstDayNextMonth.difference(firstDayThisMonth).inDays)
                .toList();
            return Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(MediaQuery.of(context).size.height / 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 90,
                      ),
                      Text(
                        getMonthsName(DateTime.now().month),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 90,
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.subtitle1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 25),
                          child: Container(
                            child: DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .apply(color: Theme.of(context).canvasColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Дата",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
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
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                body: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
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
                                                    .withOpacity(0.7)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color:
                                                    list.indexOf(entry) % 2 == 0
                                                        ? Colors.blue
                                                            .withOpacity(0.3)
                                                        : Colors.grey
                                                            .withOpacity(0.3),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "${list.indexOf(entry) + 1}",
                                                    style: TextStyle(
                                                        fontFamily: "Exo2",
                                                        color: list.indexOf(
                                                                        entry) +
                                                                    1 ==
                                                                DateTime.now()
                                                                    .day
                                                            ? Colors.red
                                                            : Colors.black),
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
                                  .toList())),
                    )));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
