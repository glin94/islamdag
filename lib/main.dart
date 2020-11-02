import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/utils.dart';

import 'app.dart';
import 'bloc/article_bloc/simple_bloc_observer.dart';

void main() async {
  initTimeLang();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}
