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
  late PageController _horizontalPageController;
  PageController get verticalPageController => _verticalPageController;
  PageController get horizontalPageController => _horizontalPageController;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  MovieDetailsViewModel(
      {required IMovieRepository movieRepository, required int movieIndex})
      : _movieRepository = movieRepository,
        _currentVerticalIndex = movieIndex {
    _init();
  }

  void _init() async {
    _fetchMoviesStream();
    _setControllers();
    notifyListeners();
  }

  void onHorizontalScroll(int index) {
    _currentHorizontalIndex = index;
    notifyListeners();
  }

  void onVerticalScroll(int index) {
    _currentVerticalIndex = index;
    _currentHorizontalIndex = 0;
    notifyListeners();
    print(index);
    print(_currentVerticalIndex);
  }

  Future<void> _fetchMoviesStream() async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesStream();
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  void disposeControllers() {
    _verticalPageController.dispose();
  }

  void _setControllers() {
    _verticalPageController = PageController(
        viewportFraction: 0.9,
        keepPage: false,
        initialPage: _currentVerticalIndex,
        );
    _horizontalPageController = PageController(
      viewportFraction: 0.9,
      keepPage: false,
    );
  }
}
