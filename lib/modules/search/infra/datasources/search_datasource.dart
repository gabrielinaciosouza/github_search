import 'package:githubsearch/modules/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>>getSearch(String searchText);   //classe abstrata do datasource, traz infos da api
}