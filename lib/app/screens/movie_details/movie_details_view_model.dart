// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';

import '../../../domain/movie/imovie.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  int _currentHorizontalIndex = 0;
  int get currentHorizontalIndex => _currentHorizontalIndex;

  int _currentVerticalIndex;
  int get currentVerticalIndex => _currentVerticalIndex;

  final IMovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;
  late PageController _verticalPageController;
  PageController get verticalPageController => _verticalPageController;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  MovieDetailsViewModel(
      {required IMovieRepository movieRepository, required int movieIndex})
      : _movieRepository = movieRepository,
        _currentVerticalIndex = movieIndex {
    _fetchMoviesStream();
  }

  void onHorizontalScroll(int index) {
    _currentHorizontalIndex = index;
    notifyListeners();
  }

  void onVerticalScroll(int index) {
    _currentVerticalIndex = index;
    _currentHorizontalIndex = 0;
    notifyListeners();
  }

  Future<void> _fetchMoviesStream() async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesStream();
      _verticalPageController =
          PageController(initialPage: _currentVerticalIndex);
      notifyListeners();
      print('got ');
    } catch (e) {
      print(e.toString());
    }
  }

  void disposeControllers() {
    _verticalPageController.dispose();
  }
}
