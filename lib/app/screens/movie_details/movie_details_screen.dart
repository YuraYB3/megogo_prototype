import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import 'widgets/movie_list_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailsScreen({super.key, required this.model});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void didChangeDependencies() {
    log('CHANGED MovieDetailsScreen');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MovieDetailsScreen oldWidget) {
    log('UPDATED MovieDetailsScreen');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSED MovieDetailsScreen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: MovieListWidget(
        movieId: widget.model.movieId,
        movieData: widget.model.movieList,
        onHorizontalScroll: widget.model.onHorizontalScroll,
        onVerticalScroll: widget.model.onVerticalScroll,
        getTrailerId: widget.model.getTrailerId,
        videoService: widget.model.videoService,
      ),
    );
  }
}
