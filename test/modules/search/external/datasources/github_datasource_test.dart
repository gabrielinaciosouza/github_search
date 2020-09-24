import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/modules/search/external/datasources/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio{} // deve-se sempre mocar o dio pois os testes devem ser offline

main(){

  final dio = DioMock();
  final datasource = GitHubDataSource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200));  //Resposta do dio implementada, colocado o result pra simular a mesma resposta da api

    final future = datasource.getSearch('searchText'); //chamado do metodo, como é um future pode fazer dessa forma sem o await

    expect(future, completes); //se completar o future então está certo.
  });
}
