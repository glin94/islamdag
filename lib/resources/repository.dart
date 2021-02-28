import 'dart:async';
import 'package:hive/hive.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/api_provider.dart';
import 'package:islamdag/utils.dart';

class Repository {
  final areasBox = Hive.box<Area>("areas");
  // final regionsBox = Hive.box<Area>("regions");

  static final Repository _repo = Repository._internal();
  static Repository get() {
    return _repo;
  }

  Repository._internal();

  Future<List<Article>> getArticles(String slug, int page) async {
    return await fetchArticles(slug, page);
  }

  Future<List<Area>> getAreas() async {
    if (areasBox.isEmpty) {
      final areaList = await fetchAreas();
      areasBox.addAll(areaList);
    }
    return areasBox.values.toList();
  }

  StreamController<Area> _regionContoller = StreamController<Area>.broadcast();

  Stream<Area> get regionStream => _regionContoller.stream;

  void changePrayTimeArea(Area area) async {
    areasBox.values.toList().forEach((area) {
      area.selected = false;
      area.save();
    });
    area.selected = true;
    area.save();
    _regionContoller.add(area);
  }

  Area get getSelectedArea => areasBox.isEmpty
      ? defaultArea
      : areasBox.values.toList().firstWhere((area) => area.selected);

  Future<List<dynamic>> getNamazTime(Area area) async => fetchPrayTime(area.id);
}
