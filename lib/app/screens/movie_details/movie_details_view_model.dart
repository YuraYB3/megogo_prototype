// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';

import '../../../domain/movie/imovie.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  int _currentHorizontalIndex = 0;
  int get currentHorizontalIndex => _currentHorizontalIndex;

  int _currentVerticalIndex = 0;
  int get currentVerticalIndex => _currentVerticalIndex;

  final IMovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;

  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  MovieDetailsViewModel({required IMovieRepository movieRepository})
      : _movieRepository = movieRepository {
    _fetchMoviesStream();
  }

  void onHorizontalScroll(int index) {
    _currentHorizontalIndex = index;
    notifyListeners();
  }

  void onVerticalScroll(int index) {
    _currentVerticalIndex = index;
    _setDefaultValues();
    notifyListeners();
  }

  void _setDefaultValues() {
    _currentHorizontalIndex = 0;
  }

  Future<void> _fetchMoviesStream() async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesStream();
      notifyListeners();
      print('got ');
    } catch (e) {
      print(e.toString());
    }
  }

  void moveToPreviousPage() {
    _currentHorizontalIndex--;
    notifyListeners();
  }

  void moveToNextPage() {
    _currentHorizontalIndex++;
    print('move to next page $currentHorizontalIndex ');
    notifyListeners();
  }
}
