import 'package:flutter_modular/flutter_modular.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/domain/repositories/search_repository.dart';

mixin SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText); //Either para forçar o tratamento de erros
}

@Injectable(singleton: false)
class SearchByTextImpl implements SearchByText {

  final SearchRepository repository;      //injeção de dependencia de repository
  SearchByTextImpl(this.repository);    //injeção de dependencia de repository

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String textSearch) async {
    var option = optionOf(textSearch);
    return option.fold(() => Left(InvalidTextError()), (text) async {
      var result = await repository.search(text);
      return result.where((r) => r.isNotEmpty, () => EmptyList());
    });
  }

}