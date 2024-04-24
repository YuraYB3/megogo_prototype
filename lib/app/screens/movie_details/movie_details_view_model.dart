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

  bool _isVideoPlaying = false;
  bool get isVideoPlaying => _isVideoPlaying;

  MovieDetailsViewModel({required IMovieRepository movieRepository})
      : _movieRepository = movieRepository {
    _fetchMoviesStream();
  }

  void onHorizontalScroll(int index) {
    _currentHorizontalIndex = index;
    _isVideoPlaying = false;
    notifyListeners();
  }

  void onVerticalScroll(int index) {
    _currentVerticalIndex = index;
    _currentHorizontalIndex = 0;
    _isVideoPlaying = false;
    notifyListeners();
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

  void onPlayButtonClicked(){
    _isVideoPlaying=!_isVideoPlaying;
    notifyListeners();
  }

  
}
