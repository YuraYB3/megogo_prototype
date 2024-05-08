import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__service.dart';
import 'package:megogo_prototype/locator.dart';
import 'package:provider/provider.dart';

import '../../../domain/movie/imovie.dart';
import 'movie_details_screen.dart';
import 'movie_details_view_model.dart';

class MovieDetailsFactory {
  static Widget build({required int movieId, required List<IMovie> movieList}) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(
        videoService: locator.get<IVideoPlayerControllersService>(),
        movieIndex: movieId,
        movieList: movieList,
      ),
      child: Consumer<MovieDetailsViewModel>(
        builder: (context, value, child) {
          return MovieDetailsScreen(
            model: value,
          );
        },
      ),
    );
  }
}
