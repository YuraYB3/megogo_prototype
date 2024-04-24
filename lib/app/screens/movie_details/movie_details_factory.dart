import 'package:flutter/material.dart';
import 'package:megogo_prototype/domain/movie/imovie_repository.dart';
import 'package:megogo_prototype/locator.dart';
import 'package:provider/provider.dart';

import 'movie_details_view.dart';
import 'movie_details_view_model.dart';

class MovieDetailsFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(
          movieRepository: locator.get<IMovieRepository>(),
         ),
      child: Consumer<MovieDetailsViewModel>(
        builder: (context, value, child) {
          return MovieDetailView(
            model: value,
          );
        },
      ),
    );
  }
}
