// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/routing/routes.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';
import 'package:megogo_prototype/domain/navigation/inavigation_util.dart';

import '../../../domain/movie/imovie.dart';

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;
  HomeViewModel(
      {required INavigationUtil navigationUtil,
      required IMovieRepository movieRepository})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository {
    _fetchMoviesStream();
  }

  void onCellClicked() {
    _navigationUtil.navigateTo(routeDetails, data: _movieStreamList);
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
}
