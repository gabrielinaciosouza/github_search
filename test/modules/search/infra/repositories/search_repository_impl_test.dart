import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/infra/datasources/search_datasource.dart';
import 'package:githubsearch/modules/search/infra/models/result_search_model.dart';
import 'package:githubsearch/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';


class SearchDatasourceMock extends Mock implements SearchDatasource{}

main(){
  final datasource = SearchDatasourceMock();   // instancia fake para searchdatasource
  final repository = SearchRepositoryImpl(datasource); // instancia de search repository

  test('Deve retornar uma lista de ResultSearch', () async {

    when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearchModel>[]); // retorna result search model para a solicitação do getsearch

    final result = await repository.search('Gabriel');   //resultado da chamada da classe (retorna null quando a classe nao esta implementada com o retorno esperado)
    expect(result | null, isA<List<ResultSearch>>());  // espera uma lista de resultserch
  });

  test('Deve retornar um erro se o datasource falhar', () async {

    when(datasource.getSearch(any)).thenThrow(Exception()); // joga uma exception para a chamada do metodo

    final result = await repository.search('Gabriel');   //resultado da chamada da classe (retorna null quando a classe nao esta implementada com o retorno esperado), nesse caso vai retornar uma exception, que sera tratada no metodo
    expect(result.fold(id, id), isA<DatasourceError>());  // espera um datasource error
  });
}