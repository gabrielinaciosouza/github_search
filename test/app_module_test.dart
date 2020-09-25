import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/app_module.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:githubsearch/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

import 'modules/search/utils/github_response.dart';


class DioMock extends Mock implements Dio {}

main(){

  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Deve recuperar o useCase sem erro', (){
    final useCase = Modular.get<SearchByText>();
    expect(useCase, isA<SearchByTextImpl>());
  });

  test('Deve recuperar uma lista se ResultSearch', () async {

    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final useCase = Modular.get<SearchByText>();
    final result = await useCase('Gabriel');

    expect(result | null, isA<List<ResultSearch>>());
  });
}