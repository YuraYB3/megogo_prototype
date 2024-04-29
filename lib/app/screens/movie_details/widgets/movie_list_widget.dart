import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/trailers_list_widget.dart';

import '../../../../domain/movie/imovie.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({
    super.key,
    required this.movieData,
    required this.horizontalPageController,
    required this.verticalPageController,
    required this.onHorizontalScroll,
    required this.onVerticalScroll,
    required this.currentTrailerId,
  });

  final List<IMovie> movieData;
  final PageController horizontalPageController;
  final PageController verticalPageController;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;
  final int currentTrailerId;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didUpdateWidget(MovieListWidget oldWidget) {
    log('UPDATED MovieListWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSED MovieListWidget');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    log('CHANGED MovieListWidget');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log('EXPANDED');
    return Expanded(
      child: PageView.custom(
        controller: widget.verticalPageController,
        onPageChanged: (value) {
          log("CHANGED VERTICAL TO $value");
          widget.onVerticalScroll(value, widget.movieData[value].documentId);
        },
        scrollDirection: Axis.vertical,
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return TrailersListWidget(
            onHorizontalScroll: widget.onHorizontalScroll,
            horizontalPageController: widget.horizontalPageController,
            movie: widget.movieData[index],
            currentTrailerId: widget.currentTrailerId,
          );
        }, childCount: widget.movieData.length),
      ),
    );
  }
}
