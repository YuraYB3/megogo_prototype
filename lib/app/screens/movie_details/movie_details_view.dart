import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import '../../../domain/movie/imovie.dart';
import 'widgets/bottom_row_widget.dart';
import 'widgets/video_screen.dart';

class MovieDetailView extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailView({super.key, required this.model});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void dispose() {
    widget.model.disposeControllers();
    super.dispose();
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
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            final List<IMovie> movieData = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: widget.model.verticalPageController,
                    onPageChanged: (value) {
                      widget.model.onVerticalScroll(value);
                      setState(() {});
                    },
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, verticalIndex) {
                      return PageView.builder(
                        controller: widget.model.horizontalPageController,
                        onPageChanged: (value) {
                          widget.model.onHorizontalScroll(value);
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, horizontalIndex) {
                          return Center(
                              child: Text(
                              movieData[verticalIndex]
                                  .trailer[horizontalIndex]
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),);
                        },
                        itemCount: movieData[verticalIndex].trailer.length,
                      );
                    },
                    itemCount: movieData.length,
                  ),
                ),
                BottomRowWidget(
                  listLength: movieData[widget.model.currentVerticalIndex]
                      .trailer
                      .length,
                  currentHorizontalIndex: widget.model.currentHorizontalIndex,
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          }),
    );
  }
}
/*
VideoScreen(
                              url: movieData[verticalIndex]
                                  .trailer[horizontalIndex]
                                  .toString());*/

/*
Text(
                              movieData[verticalIndex]
                                  .trailer[horizontalIndex]
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            */