import 'package:flutter/material.dart';

import '../screens/home/home_view_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeHome:
        return MaterialPageRoute(
          builder: (_) => _buildHomeSettings(routeSettings),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }
}
