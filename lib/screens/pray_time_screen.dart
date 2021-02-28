import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/areas_search_screen.dart';
import 'package:islamdag/widgets/pray_time_region.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class PrayTimeScreen extends StatefulWidget {
  final Area area;

  const PrayTimeScreen({
    Key key,
    this.area,
  }) : super(key: key);

  @override
  _PrayTimeScreenState createState() => _PrayTimeScreenState();
}

class _PrayTimeScreenState extends State<PrayTimeScreen> {
  String today = "";

  @override
  void initState() {
    super.initState();
    today = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<Area>(
            initialData: widget.area,
            stream: Repository.get().regionStream,
            builder: (context, snapshot) {
              return CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                      flexibleSpace: CustomGradient(),
                      elevation: 0,
                      actions: [
                        IconButton(
                            icon: Icon(SimpleLineIcons.location_pin),
                            onPressed: () => showSearch(
                                  delegate: AreasSearchDelegate(),
                                  context: context,
                                )
                            // Navigator.of(context).push(
                            //   CupertinoPageRoute(
                            //     builder: (context) => PrayTimeRegionList(),
                            //   ),
                            // ),
                            )
                      ],
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "Время намаза на ${getMonthsName(DateTime.now().month)}"),
                          Text(
                            snapshot.data.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(3, 3, 0, 14),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Дата"),
                              Text("Фад."),
                              Text("Вос."),
                              Text("Зухр"),
                              Text("Аср"),
                              Text("Маг."),
                              Text("Иша"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          color: Colors.white,
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  child: FutureBuilder<List<dynamic>>(
                                      future: Repository.get()
                                          .getNamazTime(snapshot.data),
                                      builder: (context, _snapshot) {
                                        if (_snapshot.hasData) {
                                          return Column(
                                              children: _snapshot.data
                                                  .map<DefaultTextStyle>(
                                                      (entry) =>
                                                          DefaultTextStyle(
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Exo2",
                                                                color: entry[
                                                                            "date"] ==
                                                                        today
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.6)
                                                                        .withOpacity(
                                                                            0.7)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: _snapshot.data.indexOf(entry) %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                                0.3)
                                                                        : Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                0.3),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15))),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "${_snapshot.data.indexOf(entry) + 1}",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Exo2",
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color: _snapshot.data.indexOf(entry) + 1 == DateTime.now().day
                                                                                ? Colors.red
                                                                                : Colors.black.withOpacity(0.7)),
                                                                      ),
                                                                      Text(entry[
                                                                              "times"]
                                                                          [
                                                                          "fajr"]),
                                                                      Text(entry[
                                                                              "times"]
                                                                          [
                                                                          "sunrise"]),
                                                                      Text(entry[
                                                                              "times"]
                                                                          [
                                                                          "dhuhr"]),
                                                                      Text(entry[
                                                                              "times"]
                                                                          [
                                                                          "asr"]),
                                                                      Text(entry[
                                                                              "times"]
                                                                          [
                                                                          "maghrib"]),
                                                                      Text(
                                                                        entry["times"]
                                                                            [
                                                                            "night"],
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          ))
                                                  .toList());
                                        } else
                                          return const Loader();
                                      }))))
                    ])),
                  )
                ],
              );
            }));
  }
}
