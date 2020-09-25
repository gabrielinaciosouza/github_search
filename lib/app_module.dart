import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:githubsearch/app_widget.dart';
import 'package:githubsearch/modules/search/domain/usecases/search_by_text.dart';
import 'package:githubsearch/modules/search/external/datasources/github_datasource.dart';
import 'package:githubsearch/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:githubsearch/modules/search/presenter/search/search_bloc.dart';
import 'package:githubsearch/modules/search/presenter/search/search_page.dart';
class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => GitHubDataSource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchBloc(i())),
  ];

  @override

  Widget get bootstrap => AppWidget();

  @override

  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SearchPage()),
  ];

}