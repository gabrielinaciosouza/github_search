import 'package:dartz/dartz.dart';
import 'package:githubsearch/modules/search/domain/entities/result_search.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText); //Contrato para o repository
}