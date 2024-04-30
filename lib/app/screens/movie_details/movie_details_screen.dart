import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
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
  void didUpdateWidget(MovieDetailsScreen oldWidget) {
    log('UPDATED MovieDetailsScreen');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSED MovieDetailsScreen');
    super.dispose();
    widget.model.disposeControllers();
  }

  @override
  void didChangeDependencies() {
    log('CHANGED MovieDetailsScreen');
    super.didChangeDependencies();
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
            return const LoadingWidget();
          }
          final List<IMovie> movieData = snapshot.data!;
          log('BUILD COLUMN');
          return Column(
            children: [
              MovieListWidget(
                movieId: widget.model.movieId,
                movieData: movieData,
                horizontalPageController: widget.model.horizontalPageController,
                verticalPageController: widget.model.verticalPageController,
                onHorizontalScroll: widget.model.onHorizontalScroll,
                onVerticalScroll: widget.model.onVerticalScroll,
              ),
            ],
          );
        },
      ),
    );
  }
}
