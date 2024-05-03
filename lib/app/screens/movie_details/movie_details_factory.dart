import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/movie/imovie.dart';
import 'movie_details_screen.dart';
import 'movie_details_view_model.dart';

class MovieDetailsFactory {
  static Widget build({required int movieId, required List<IMovie> movieList}) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(
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
