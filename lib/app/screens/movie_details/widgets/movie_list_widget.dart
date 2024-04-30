import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
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
    required this.movieId,
  });

  final List<IMovie> movieData;
  final PageController horizontalPageController;
  final PageController verticalPageController;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;
  final int movieId;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didUpdateWidget(MovieListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
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
        childrenDelegate: SliverChildBuilderDelegate((context, verticalIndex) {
          return widget.movieId == verticalIndex
              ? TrailersListWidget(
                  onHorizontalScroll: widget.onHorizontalScroll,
                  horizontalPageController: widget.horizontalPageController,
                  movie: widget.movieData[verticalIndex],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity * 0.5,
                    height: double.infinity * 0.5,
                    color: Colors.black,
                    child: CachedImageWidget(
                      height: double.infinity * 0.5,
                      width: double.infinity * 0.5,
                      imageUrl: widget.movieData[verticalIndex].poster,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                );
        }, childCount: widget.movieData.length),
      ),
    );
  }
}
