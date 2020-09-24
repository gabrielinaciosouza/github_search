import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText); //Either para forçar o tratamento de erros
}

class SearchByTextImpl implements SearchByText {

  final SearchRepository repository;      //injeção de dependencia de repository
  SearchByTextImpl(this.repository);    //injeção de dependencia de repository

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText) async {
    if(searchText == null || searchText.isEmpty){      // implementação para passar no teste
      return Left(InvalidTextError());
    }
    return repository.search(searchText);
  }

}