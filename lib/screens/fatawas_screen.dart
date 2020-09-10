import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamdag/bloc/article_bloc/article_bloc.dart';
import 'package:islamdag/widgets/fatawas_list.dart';
import 'package:islamdag/widgets/floating_button.dart';

class FatawasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FatawaFloatingButton(),
        backgroundColor: Colors.white,
        body: BlocProvider(
            create: (_) => ArticleBloc("fatawa")..add(Fetch()),
            child: FatawasList()));
  }
}
