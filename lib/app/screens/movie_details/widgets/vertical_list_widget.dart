import 'package:flutter/material.dart';

import '../../../../domain/movie/imovie.dart';
import 'trailers_list_widget.dart';

class VerticalListWidget extends StatelessWidget {
  const VerticalListWidget({
    super.key,
    required this.movieData,
    required this.verticalPageController,
    required this.onHorizontalScroll,
    required this.onVerticalScroll,
  });

  final List<IMovie> movieData;
  final PageController verticalPageController;
  final Function onHorizontalScroll;
  final Function onVerticalScroll;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: PageView.builder(
          controller: verticalPageController,
          onPageChanged: (value) {
            onVerticalScroll(value);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, verticalIndex) {
            return TrailersListWidget(
              onHorizontalScroll: onHorizontalScroll,
              trailersURLs: movieData[verticalIndex].trailer,
            );
          },
          itemCount: movieData.length,
        ),
      ),
    );
  }
}
