import 'package:get_it/get_it.dart';

import 'app/routing/navigation_util.dart';
import 'domain/navigation/inavigation_util.dart';

final locator = GetIt.instance;

void initServices(){
  initNavigation();
}

void initNavigation() {
  locator.registerSingleton<INavigationUtil>(
    NavigationUtil(),
  );
}
