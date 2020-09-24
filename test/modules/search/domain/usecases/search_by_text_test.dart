import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/domain/repositories/search_repository.dart';
import 'package:githubsearch/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';


class SearchRepositoryMock extends Mock implements SearchRepository{} //cria uma classe fake para realizar os testes

main() {



  final repository = SearchRepositoryMock(); //instancia da classe fake
  final usecase = SearchByTextImpl(repository); // instância da classe

  test('Deve retornar uma lista de ResultSearch', () async {

    when(repository.search(any)).thenAnswer((_) async  => Right(<ResultSearch>[])); //cria o retorno esperado para o metodo

    final result = await usecase.call('Gabriel');
    expect(result | null, isA<List<ResultSearch>>());  // deve dar o lado direito, caso der nulo vai dar erro no teste
  });

  test('Deve retornar um InvalidTextError caso o texto seja inválido', () async {

    when(repository.search(any)).thenAnswer((_) async  => Right(<ResultSearch>[])); //cria o retorno esperado para o metodo

    var result = await usecase(null);

    expect(result.isLeft(), true);  //deve vim lado esquerdo para passar no teste (não é necessaria, porém é uma opção)
    expect(result.fold(id, id), isA<InvalidTextError>());  // deve vir a exception descrita para passar no teste


    result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>()); // deve vir a exeption para passar no teste (implementar no metodo)
  });
  
}