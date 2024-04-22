import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/routing/routes.dart';
import 'package:megogo_prototype/domain/navigation/inavigation_util.dart';

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  HomeViewModel({required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil;
  void onCellClicked() {
    _navigationUtil.navigateTo(routeDetails);
  }
}
