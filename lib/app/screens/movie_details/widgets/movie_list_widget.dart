import 'package:flutter/material.dart';

import '../../../../domain/movie/imovie.dart';
import 'trailers_list_widget.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    super.key,
    required this.movieData,
    required this.verticalPageController,
    required this.onHorizontalScroll,
    required this.onVerticalScroll,
    required this.horizontalPageController,
    required this.trailerId,
  });

  final List<IMovie> movieData;
  final PageController verticalPageController;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;
  final PageController horizontalPageController;
  final int trailerId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: verticalPageController,
        onPageChanged: (value) {
          onVerticalScroll(value);
        },
        scrollDirection: Axis.vertical,
        itemBuilder: (context, verticalIndex) {
          return TrailersListWidget(
            trailerId: trailerId,
            onHorizontalScroll: onHorizontalScroll,
            trailersURLs: movieData[verticalIndex].trailer,
            horizontalPageController: horizontalPageController,
          );
        },
        itemCount: movieData.length,
      ),
    );
  }
}