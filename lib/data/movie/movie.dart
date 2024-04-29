import 'package:megogo_prototype/domain/movie/imovie.dart';

class Movie implements IMovie {
  @override
  String documentId;

  @override
  String poster;

  @override
  String title;

  @override
  List<dynamic> trailers;

  Movie(
      {required this.documentId,
      required this.poster,
      required this.title,
      required this.trailers});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        documentId: json['documentId'],
        poster: json['poster'],
        title: json['title'],
        trailers: json['trailer']);
  }
}
