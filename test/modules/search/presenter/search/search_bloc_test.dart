import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/domain/usecases/search_by_text.dart';
import 'package:githubsearch/modules/search/presenter/search/search_bloc.dart';
import 'package:githubsearch/modules/search/presenter/search/state/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText{}

main(){
  final useCase = SearchByTextMock();
  final bloc = SearchBloc(useCase);



  test('Deve retornar os estados na ordem correta', (){
    when(useCase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSuccess>(),
    ]));
    bloc.add('gabriel');
  });

  test('Deve retornar um error', (){
    when(useCase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchError>(),
    ]));
    bloc.add('gabriel');
  });
}