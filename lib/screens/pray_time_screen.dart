import 'package:flutter/material.dart';
import 'package:islamdag/resources/repository.dart';

import '../utils.dart';

class PrayTimePage extends StatelessWidget {
  const PrayTimePage({Key key}) : super(key: key);

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
                      Size.fromHeight(MediaQuery.of(context).size.height / 13),
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
                                                        ? Colors.grey
                                                            .withOpacity(0.3)
                                                        : Colors.blue
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

            // return Row(
            //   children: <Widget>[
            //     Column(
            //         children: list
            //             .map((entry) => Text(
            //                   "${list.indexOf(entry) + 1}",
            //                   style: TextStyle(
            //                       color: list.indexOf(entry) + 1 ==
            //                               DateTime.now().day
            //                           ? Colors.red
            //                           : Colors.black),
            //                 ))
            //             .toList()),
            //     Column(
            //         children: list
            //             .map((entry) => Text(
            //                   entry["namaz_1"],
            //                   style: TextStyle(
            //                       color: list.indexOf(entry) + 1 ==
            //                               DateTime.now().day
            //                           ? Colors.red
            //                           : Colors.black),
            //                 ))
            //             .toList()),
            //   ],
            // );

            // SingleChildScrollView(

            //   child:

            //   DataTable(
            //       columnSpacing: 14,
            //       columns: [
            //         DataColumn(
            //             label: Text(
            //           "Дата",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Фад.",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Вос.",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Зухр",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Аср",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Маг.",
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Иша",
            //         )),
            //       ],
            //       rows: list
            //           .map<DataRow>((entry) => DataRow(cells: [
            //                 DataCell(Text(
            //                   "${list.indexOf(entry) + 1}",
            //                   style: TextStyle(
            //                       color: list.indexOf(entry) + 1 ==
            //                               DateTime.now().day
            //                           ? Colors.red
            //                           : Colors.black),
            //                 )),
            //                 DataCell(Text(entry["namaz_1"])),
            //                 DataCell(Text(entry["voshod"])),
            //                 DataCell(Text(entry["namaz_2"])),
            //                 DataCell(Text(entry["namaz_3"])),
            //                 DataCell(Text(entry["namaz_4"])),
            //                 DataCell(Text(entry["namaz_5"])),
            //               ]))
            //           .toList()),
            // );
          } else
            return Center(
              child: Text(snapshot.error.toString()),
            );
        });
  }
}
