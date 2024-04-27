import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import '../../../domain/movie/imovie.dart';
import 'widgets/vertical_list_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailScreen({super.key, required this.model});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
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
              VerticalListWidget(
                horizontalPageController: widget.model.horizontalPageController,
                movieData: movieData,
                onHorizontalScroll: widget.model.onHorizontalScroll,
                onVerticalScroll: widget.model.onVerticalScroll,
                verticalPageController: widget.model.verticalPageController,
                defaultVerticalIndex: widget.model.currentVerticalIndex,
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
StreamBuilder<List<IMovie>>(
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
              VerticalListWidget(
                movieData: movieData,
                onHorizontalScroll: widget.model.onHorizontalScroll,
                onVerticalScroll: widget.model.onVerticalScroll,
                verticalPageController: widget.model.verticalPageController,
              ),
              BottomRowWidget(
                listLength:
                    movieData[widget.model.currentVerticalIndex].trailer.length,
                currentHorizontalIndex: widget.model.currentHorizontalIndex,
              ),
              const SizedBox(
                height: 40,
              )
            ],
          );
        },
      ),*/

      /*\Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 10,
                controller:
                    PageController(viewportFraction: 0.9, initialPage: 0),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      controller:
                          PageController(viewportFraction: 0.9, initialPage: 0),
                      itemBuilder: (context, index2) {
                        
                        return Container(
                          color: colorsList[Random().nextInt(10)],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(index.toString() + index2.toString()),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )*/