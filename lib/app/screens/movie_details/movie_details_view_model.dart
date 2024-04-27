// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';

import '../../../domain/movie/imovie.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  int _trailerId = 0;
  int get trailerId => _trailerId;

  int _movieId;
  int get movieId => _movieId;

  final IMovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;
  late PageController _verticalPageController;
  late PageController _horizontalPageController;
  PageController get verticalPageController => _verticalPageController;
  PageController get horizontalPageController => _horizontalPageController;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;
  final Map<int, int> _trailersHistory = <int, int>{};

  MovieDetailsViewModel(
      {required IMovieRepository movieRepository, required int movieIndex})
      : _movieRepository = movieRepository,
        _movieId = movieIndex {
    _init();
  }

  void _init() async {
    _fetchMoviesStream();
    _setControllers();
    notifyListeners();
  }

  void onHorizontalScroll(int index) {
    _trailerId = index;
    _saveTrailerId();
    notifyListeners();
  }

  void onVerticalScroll(int index) {
    _movieId = index;
    _trailerId = _getTrailerId();
    notifyListeners();
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
    _horizontalPageController.dispose();
  }

  void _setControllers() {
    _verticalPageController = PageController(
      viewportFraction: 0.9,
      keepPage: false,
      initialPage: _movieId,
    );
    _horizontalPageController = PageController(
      viewportFraction: 0.9,
    
    );
  }

  int _getTrailerId() {
    return _trailersHistory[_movieId] ?? 0;
  }

  void _saveTrailerId() {
    _trailersHistory[_movieId] = _trailerId;
  }
}
