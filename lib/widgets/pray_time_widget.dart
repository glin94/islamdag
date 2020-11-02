import 'package:flutter/material.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/screens/screens.dart';
import 'package:islamdag/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';

class NamazTime extends StatelessWidget {
  const NamazTime({
    Key key,
  }) : super(key: key);

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
            final today = list.elementAt(DateTime.now().day - 2);
            return InkWell(
              onTap: () => pushNewScreen(context,
                  withNavBar: false, screen: PrayTimeScreen()),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Colors.blue, Colors.green])),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Время намаза",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: today.values
                            .map<Widget>((item) => Container(
                                decoration: BoxDecoration(
                                  color: DateTime.now().isBefore(
                                          DateFormat("hh:mm").parse(item))
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(item,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: DateTime.now().isBefore(
                                                    DateFormat("hh:mm")
                                                        .parse(item))
                                                ? Colors.black54
                                                : Colors.white,
                                            fontWeight: FontWeight.bold))))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else
            return NamazWidgetShimmer();
        });
  }
}
