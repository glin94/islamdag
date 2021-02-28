import 'package:flutter/material.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:islamdag/widgets/pray_time_region.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';

class NamazTime extends StatelessWidget {
  const NamazTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Area>(
        initialData: Repository.get().getSelectedArea,
        stream: Repository.get().regionStream,
        builder: (BuildContext c, AsyncSnapshot<Area> s) {
          if (s.hasData) {
            final area = s.data;
            return InkWell(
              onTap: () => pushNewScreen(context,
                  withNavBar: false,
                  screen: PrayTimeScreen(
                    area: area,
                  )),
              child: FutureBuilder<List<dynamic>>(
                  future: Repository.get().getNamazTime(s.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final list = snapshot.data;
                      final today =
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      final todayNamaz = list.elementAt(list
                          .indexWhere((element) => element["date"] == today));
                      return list.isEmpty
                          ? const ErrorWidgetScreen()
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Colors.blue,
                                      Colors.green,
                                    ]),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(area.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: todayNamaz["times"]
                                            .values
                                            .map<Widget>(
                                              (item) => Container(
                                                decoration: BoxDecoration(
                                                    color: DateTime.now()
                                                            .isBefore(
                                                                DateFormat(
                                                                        "hh:mm")
                                                                    .parse(
                                                                        item))
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                child: Text(
                                                  item,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                          color: DateTime.now()
                                                                  .isBefore(DateFormat(
                                                                          "hh:mm")
                                                                      .parse(
                                                                          item))
                                                              ? Colors.black54
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      )
                                    ],
                                  )),
                            );
                    } else
                      return NamazWidgetShimmer();
                  }),
            );
          } else
            return NamazWidgetShimmer();
        });
  }
}
