// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__service.dart';

import '../../../domain/movie/imovie.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  int _movieId;
  int get movieId => _movieId;
  final List<IMovie> _movieList;
  List<IMovie> get movieList => _movieList;
  final Map<String, int> _trailersHistory = <String, int>{};

  final IVideoPlayerControllersService _videoService;
  IVideoPlayerControllersService get videoService => _videoService;

  MovieDetailsViewModel(
      {required int movieIndex,
      required List<IMovie> movieList,
      required IVideoPlayerControllersService videoService})
      : _movieId = movieIndex,
        _movieList = movieList,
        _videoService = videoService;

  void onHorizontalScroll(int index, String documentId) {
    log('-----------');
    log('Horizontal scroll');
    log('-----------');
    _saveTrailerId(index, documentId);
  }

  void onVerticalScroll(int index) {
    log('-----------');
    log('Vertical scroll');
    log('-----------');
    _movieId = index;
    notifyListeners();
  }

  int getTrailerId(String documentId) {
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
