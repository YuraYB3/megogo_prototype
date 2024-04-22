import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_factory.dart';

import '../screens/home/home_view_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
          builder: (_) => _buildHomeSettings(settings),
        );
      case routeDetails:
        return MaterialPageRoute(
          builder: (_) => _buildMovieDetailsSettings(settings),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );
    }
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }

  Widget _buildMovieDetailsSettings(RouteSettings settings) {
    return MovieDetailsFactory.build();
  }
}
