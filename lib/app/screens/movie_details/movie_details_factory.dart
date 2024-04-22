import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_details_view.dart';
import 'movie_details_view_model.dart';

class MovieDetailsFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(),
      child: Consumer<MovieDetailsViewModel>(
        builder: (context, value, child) {
          return  MovieDetailView(
            model: value,
          );
        },
      ),
    );
  }
}
