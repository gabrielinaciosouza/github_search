import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/external/datasources/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {
} // deve-se sempre mocar o dio pois os testes devem ser offline

main() {
  final dio = DioMock();
  final datasource = GitHubDataSource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: jsonDecode(githubResult),
        statusCode:
            200)); //Resposta do dio implementada, colocado o result pra simular a mesma resposta da api

    final future = datasource.getSearch(
        'searchText'); //chamado do metodo, como é um future pode fazer dessa forma sem o await

    expect(future, completes); //se completar o future então está certo.
  });

  test('Deve retornar um erro se o código não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: null,
        statusCode:
            401)); //Resposta do dio implementada, para simular um erro

    final future = datasource.getSearch(
        'searchText'); //chamado do metodo, como é um future pode fazer dessa forma sem o await

    expect(future, throwsA(isA<DatasourceError>())); //espera um datasource error
  });

  test('Deve retornar um Exception se tiver um erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch(
        'searchText'); //chamado do metodo, como é um future pode fazer dessa forma sem o await

    expect(future, throwsA(isA<Exception>())); //espera um datasource error
  });
}
