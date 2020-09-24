abstract class FailureSearch implements Exception {} //Erro criado, especifico para a aplicação

class InvalidTextError implements FailureSearch {}

class DatasourceError implements FailureSearch {
  final String message;

  DatasourceError({this.message});


}