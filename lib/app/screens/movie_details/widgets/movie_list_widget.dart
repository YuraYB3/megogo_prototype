import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/trailers_list_widget.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__util.dart';

import '../../../../domain/movie/imovie.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget(
      {super.key,
      required this.movieData,
      required this.onVerticalScroll,
      required this.movieId,
      required this.onHorizontalScroll,
      required this.getTrailerId,
      required this.videoService});

  final List<IMovie> movieData;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;
  final int movieId;
  final Function getTrailerId;
  final IVideoPlayerControllersService videoService;

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
  void dispose() {
  //  widget.videoService.disposeControllers();
    log('DISPOSE MOVIE LIST');
    super.dispose();
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
          videoService: widget.videoService,
          isMovieIdAndVerticalIndexAreEqual: widget.movieId == verticalIndex,
          onHorizontalScroll: widget.onHorizontalScroll,
          movie: widget.movieData[verticalIndex],
          getTrailerId: widget.getTrailerId,
        );
      }, childCount: widget.movieData.length),
    );
  }
}
