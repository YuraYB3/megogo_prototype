import 'imovie.dart';

abstract interface class IMovieRepository {
  Stream<List<IMovie>> fetchMoviesStream();
}
