import 'package:get_it/get_it.dart';

import 'app/routing/navigation_util.dart';
import 'app/services/network/firebase_service.dart';
import 'data/movie/movie_repository.dart';
import 'domain/movie/imovie_repository.dart';
import 'domain/navigation/inavigation_util.dart';
import 'domain/network/inetwork_service.dart';

final locator = GetIt.instance;

void init() {
  initNetworkService();
  initNavigation();
  initRepos();
}

void initNetworkService() {
  locator.registerSingleton<INetworkService>(
    FirebaseService(),
  );
}

void initNavigation() {
  locator.registerSingleton<INavigationUtil>(
    NavigationUtil(),
  );
}

void initRepos() {
  locator.registerFactory<IMovieRepository>(
    () => MovieRepository(
      networkService: locator.get<INetworkService>(),
    ),
  );
}
