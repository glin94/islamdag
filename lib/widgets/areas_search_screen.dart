import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/resources/repository.dart';
import 'package:islamdag/widgets/bottom_loader.dart';
import 'package:islamdag/widgets/pray_time_region.dart';

class AreasSearchDelegate extends SearchDelegate {
  AreasSearchDelegate()
      : super(
          searchFieldLabel: "Выберите район",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(CupertinoIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Area>>(
      future: Repository.get().getAreas(),
      builder: (BuildContext context, AsyncSnapshot<List<Area>> snapshot) {
        if (snapshot.hasData) {
          return AreasList(
              areas: snapshot.data
                  .where((area) => query
                      .toLowerCase()
                      .trim()
                      .contains(area.name.toLowerCase()))
                  .toList());
        } else if (snapshot.hasError) {
          return const ErrorWidgetScreen();
        } else {
          return const Loader();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Area>>(
      future: Repository.get().getAreas(),
      builder: (BuildContext context, AsyncSnapshot<List<Area>> snapshot) {
        if (snapshot.hasData) {
          return AreasList(
            areas: snapshot.data,
          );
        } else if (snapshot.hasError) {
          return const ErrorWidgetScreen();
        } else {
          return const Loader();
        }
      },
    );
  }
}

class AreasList extends StatelessWidget {
  final List areas;
  const AreasList({
    Key key,
    this.areas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: areas
            .map<Widget>(
              (item) => ListTile(
                key: ValueKey(item.id),
                onTap: () {
                  print(item.name);
                  Repository.get().changePrayTimeArea(item);
                  Navigator.pop(context);
                },
                trailing: item.selected ? Icon(Icons.check) : SizedBox(),
                title: Text(
                  item.fullName,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
            .toList());
  }
}
