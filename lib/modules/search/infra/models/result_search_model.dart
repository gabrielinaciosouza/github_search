import 'package:githubsearch/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {  //implementação da classe anêmica com as funções toMap e fromMap

  final String title;
  final String content;
  final String img;

  ResultSearchModel({this.title, this.content, this.img});

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return new ResultSearchModel(
      title: map['title'] as String,
      content: map['content'] as String,
      img: map['img'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'title': this.title,
      'content': this.content,
      'img': this.img,
    } as Map<String, dynamic>;
  }
}