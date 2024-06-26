import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/routing/app_router.dart';
import 'package:megogo_prototype/firebase_options.dart';
import 'package:megogo_prototype/locator.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'domain/navigation/inavigation_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  final INavigationUtil navigationUtil = locator<INavigationUtil>();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: navigationUtil),
      ],
      child: App(
        appRouter: AppRouter(),
      ),
    ),
  );
}
