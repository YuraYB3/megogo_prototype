import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/movie_details_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

class MovieDetailView extends StatefulWidget {
  final MovieDetailsViewModel model;
  const MovieDetailView({super.key, required this.model});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: mainColor.withOpacity(1),
        foregroundColor: secondaryColor,
      ),
      backgroundColor: mainColor,
      body: PageView.builder(
        onPageChanged: (value) {
          widget.model.onVerticalScroll();
        },
        scrollDirection: Axis.vertical,
        
        itemBuilder: (context, verticalIndex) {
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: PageView.builder(
                    onPageChanged: (value) {
                      widget.model.onHorizontalScroll(value);
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, horizontalIndex) {
                      return Center(
                        child: Text(
                          "PAGE $verticalIndex - $horizontalIndex",
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(
                        radius: widget.model.currentHorizontalIndex == index
                            ? 8
                            : 5,
                        backgroundColor:
                            widget.model.currentHorizontalIndex == index
                                ? Colors.white
                                : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}
