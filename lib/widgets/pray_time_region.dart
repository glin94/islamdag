import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/widgets.dart';

class PrayTimeRegionList extends StatefulWidget {
  @override
  _PrayTimeRegionListState createState() => _PrayTimeRegionListState();
}

class _PrayTimeRegionListState extends State<PrayTimeRegionList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyMiddle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          middle: Text(
            'Выберите местоположение',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        child: FutureBuilder<List<Area>>(
          future: Repository.get().getAreas(),
          builder: (BuildContext context, AsyncSnapshot<List<Area>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  shrinkWrap: true,
                  children: snapshot.data
                      .map<Widget>(
                        (item) => ListTile(
                          key: ValueKey(item.id),
                          onTap: () {
                            print(item.name);
                            setState(() {
                              Repository.get().changePrayTimeArea(item);
                              Navigator.pop(context);
                            });
                          },
                          trailing:
                              item.selected ? Icon(Icons.check) : SizedBox(),
                          title: Text(
                            item.fullName,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                      .toList());
            } else if (snapshot.hasError) {
              return const ErrorWidgetScreen();
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidgetScreen extends StatelessWidget {
  const ErrorWidgetScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Ошибка'),
        )
      ],
    );
  }
}
