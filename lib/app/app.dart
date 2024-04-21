import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/home/home_view_factory.dart';
import 'package:megogo_prototype/domain/navigation/inavigation_util.dart';
import 'package:megogo_prototype/locator.dart';

import 'routing/app_router.dart';

class App extends StatefulWidget {
  final AppRouter _appRouter;

  const App({super.key, required AppRouter appRouter}) : _appRouter = appRouter;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator.get<INavigationUtil>().navigatorKey,
      onGenerateRoute: widget._appRouter.onGenerateRoute,
      home: HomeFactory.build(),
    );
  }
}
