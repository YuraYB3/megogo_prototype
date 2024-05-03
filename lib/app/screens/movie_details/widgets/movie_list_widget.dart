import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/trailers_list_widget.dart';

import '../../../../domain/movie/imovie.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({
    super.key,
    required this.movieData,
    required this.onVerticalScroll,
    required this.movieId,
    required this.onHorizontalScroll,
    required this.getTrailerId,
  });

  final List<IMovie> movieData;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;
  final int movieId;
  final Function getTrailerId;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void initState() {
    log('INIT MOVIE LIST');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    log('CHANGE MOVIE LIST');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MovieListWidget oldWidget) {
    log('UPDATE MOVIE LIST');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    log('EXPANDED');
    return PageView.custom(
      controller:
          PageController(initialPage: widget.movieId, viewportFraction: 0.9),
      onPageChanged: (value) {
        log("CHANGED VERTICAL TO $value");
        widget.onVerticalScroll(value);
      },
      scrollDirection: Axis.vertical,
      childrenDelegate: SliverChildBuilderDelegate((context, verticalIndex) {
        return TrailersListWidget(
          isMovieIdAndVerticalIndexAreEqual: widget.movieId == verticalIndex,
          onHorizontalScroll: widget.onHorizontalScroll,
          movie: widget.movieData[verticalIndex],
          getTrailerId: widget.getTrailerId,
        );
      }, childCount: widget.movieData.length),
    );
  }

  @override
  void dispose() {
    log('DISPOSE MOVIE LIST');
    super.dispose();
  }
}
