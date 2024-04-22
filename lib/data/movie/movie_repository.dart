import 'package:megogo_prototype/domain/movie/imovie.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';

import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';
import 'movie.dart';

class MovieRepository implements IMovieRepository {
  final INetworkService _networkService;

  MovieRepository({
    required INetworkService networkService,
  }) : _networkService = networkService;

  @override
  Stream<List<IMovie>> fetchMoviesStream() {
    return _networkService.fetchDataStream(collectionMovies).map(
          (dataList) => dataList.map((data) => Movie.fromJson(data)).toList(),
        );
  }
}
