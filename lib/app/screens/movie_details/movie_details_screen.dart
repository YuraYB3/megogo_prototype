import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import '../../../domain/movie/imovie.dart';
import 'widgets/movie_list_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailsScreen({super.key, required this.model});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void dispose() {
    super.dispose();
    widget.model.disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: mainColor,
      body: StreamBuilder<List<IMovie>>(
        stream: widget.model.movieStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "ERROR${snapshot.error}",
                style: TextStyle(color: secondaryColor, fontSize: 24),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          }
          final List<IMovie> movieData = snapshot.data!;
          return Column(
            children: [
              MovieListWidget(
                horizontalPageController: widget.model.horizontalPageController,
                movieData: movieData,
                onHorizontalScroll: widget.model.onHorizontalScroll,
                onVerticalScroll: widget.model.onVerticalScroll,
                verticalPageController: widget.model.verticalPageController,
                trailerId: widget.model.trailerId,
                movieId: widget.model.movieId,
              ),
            ],
          );
        },
      ),
    );
  }
}
