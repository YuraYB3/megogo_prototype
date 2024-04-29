// ignore_for_file: avoid_print

import 'dart:developer';

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
  final Map<String, int> _trailersHistory = <String, int>{};

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

  void onHorizontalScroll(int index, String documentId) {
    log('-----------');
    log('Horizontal scroll');
    log('-----------');
    _trailerId = index;
    _saveTrailerId(index, documentId);
    notifyListeners();
  }

  void onVerticalScroll(int index, String documentId) {
    log('-----------');
    log('Vertical scroll');
    log('-----------');
    _movieId = index;
    _trailerId = _getTrailerId(documentId);
    _setHorizontalController();
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
    log("SET CONTROLLERS");
    _setVerticalController();
    _setHorizontalController();
  }

  void _setVerticalController() {
    _verticalPageController = PageController(
      viewportFraction: 0.8,
      keepPage: true,
      initialPage: movieId,
    );
  }

  void _setHorizontalController() {
    _horizontalPageController = PageController(
        viewportFraction: 0.9, initialPage: trailerId, keepPage: false);
  }

  int _getTrailerId(String documentId) {
    log("GET TRAILER ID FOR MOVIE $documentId");
    return _trailersHistory[documentId] ?? 0;
  }

  void _saveTrailerId(int index, String documentId) {
    log('SAVING ID FOR MOVIE $_movieId WITH TRAILER ID $index');
    log(_trailersHistory.toString());
    _trailersHistory[documentId] = index;
    log(_trailersHistory.toString());
  }
}
