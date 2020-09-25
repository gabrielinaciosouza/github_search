import 'package:dio/dio.dart';
import 'package:githubsearch/modules/search/domain/errors/errors.dart';
import 'package:githubsearch/modules/search/infra/datasources/search_datasource.dart';
import 'package:githubsearch/modules/search/infra/models/result_search_model.dart';

extension on String {
  normalize() {
    return this.replaceAll(" ",
        "+"); //dart extensions para trocar o espaço pelo mais, pois na api do github o espaço é representado pelo +
  }
}

class GitHubDataSource extends SearchDatasource {
  final Dio dio;

  GitHubDataSource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get(
        'https://api.github.com/search/users?q=${searchText.normalize()}'); // chamando o normalize para não ter erros na busca
    if(response.statusCode ==200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList(); // fazendo a lista para o retorno
      return list;
    } else {
      throw DatasourceError();
    }


  }
}
