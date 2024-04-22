import 'package:flutter/material.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  int _currentHorizontalIndex = 0;
  int get currentHorizontalIndex => _currentHorizontalIndex;

  void onHorizontalScroll(int index) {
    _currentHorizontalIndex = index;
    notifyListeners();
  }

  void onVerticalScroll() {
    _setDefaultValues();
  }

  void _setDefaultValues() {
    _currentHorizontalIndex = 0;
    notifyListeners();
  }
}
