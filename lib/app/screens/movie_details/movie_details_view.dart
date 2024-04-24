import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import '../../../domain/movie/imovie.dart';
import 'widgets/bottom_row_widget.dart';
import 'widgets/trailers_list_widget.dart';

class MovieDetailView extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailView({super.key, required this.model});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.teal,
      ),
      backgroundColor: mainColor,
      body: StreamBuilder<List<IMovie>>(
          stream: widget.model.movieStreamList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "ERROR${snapshot.error}",
                  style: const TextStyle(color: Colors.teal, fontSize: 24),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }
            final List<IMovie> movieData = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PageView.builder(
                      onPageChanged: (value) {
                        widget.model.onVerticalScroll(value);
                      },
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, verticalIndex) {
                        return TrailersListWidget(
                          onHorizontalScroll: (p0) {
                            widget.model.onHorizontalScroll(p0);
                          },
                          trailersList: movieData[verticalIndex].trailer,
                        );
                      },
                      itemCount: movieData.length,
                    ),
                  ),
                ),
                BottomRowWidget(
                  listLength: movieData[widget.model.currentVerticalIndex]
                      .trailer
                      .length,
                  currentHorizontalIndex: widget.model.currentHorizontalIndex,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          }),
    );
  }
}
