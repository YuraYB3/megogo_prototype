import 'package:flutter/material.dart';

import '../../../../domain/movie/imovie.dart';
import 'poster_cell.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    super.key,
    required this.movieData,
    required this.onCellClicked,
  });

  final List<IMovie> movieData;
  final Function(int movieId) onCellClicked;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: movieData.length,
      itemBuilder: (context, index) {
        final IMovie movie = movieData[index];
        return PosterCell(
          posterUrl: movie.poster,
          onCellClicked: () {
            onCellClicked(index);
          },
          posterHeight: MediaQuery.of(context).size.height * 0.25,
          posterWidth: MediaQuery.of(context).size.width * 0.3,
        );
      },
      padding: const EdgeInsets.all(8.0),
    );
  }
}
