import 'package:megogo_prototype/domain/movie/imovie.dart';

class Movie implements IMovie {
  @override
  String documentId;

  @override
  String poster;

  @override
  String title;

  Movie({required this.documentId, required this.poster, required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        documentId: json['documentId'],
        poster: json['poster'],
        title: json['title']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'documentId': documentId, 'title': title, 'poster': poster};
  }
}
