import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/routing/routes.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';
import 'package:megogo_prototype/domain/navigation/inavigation_util.dart';

import '../../../domain/movie/imovie.dart';

enum HomeViewState { loading, readyToWork }

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;
  late List<IMovie> _movieList;
  List<IMovie> get movieList => _movieList;

  HomeViewState _homeViewState = HomeViewState.loading;
  HomeViewState get homeViewState => _homeViewState;
  HomeViewModel(
      {required INavigationUtil navigationUtil,
      required IMovieRepository movieRepository})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository;

  void init() {
    _fetchMoviesStream();
  }

  void onPosterClicked(int movieId, List<IMovie> movieData) {
    _navigationUtil.navigateTo(routeDetails,
        data: ({'movieId': movieId, 'movieList': movieData}));
  }

  Future<void> _fetchMoviesStream() async {
    try {
      _movieList = await _movieRepository.fetchMoviesStream().first;
      _updateHomeViewState(HomeViewState.readyToWork);
      log('got');
    } catch (e) {
      log(e.toString());
    }
  }

  void _updateHomeViewState(HomeViewState state) {
    _homeViewState = state;
    notifyListeners();
  }
}
