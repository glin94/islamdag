import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamdag/models/area.dart';
import 'package:islamdag/utils.dart';

import 'app.dart';
import 'bloc/article_bloc/simple_bloc_observer.dart';

void main() async {
  initTimeLang();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter<Area>(AreaAdapter());
  await Hive.openBox<Area>('areas');
  runApp(App());
}
