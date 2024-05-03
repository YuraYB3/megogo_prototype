import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/video_widget.dart';
import 'package:megogo_prototype/data/movie/movie_keys.dart';
import 'package:megogo_prototype/domain/movie/imovie.dart';

import 'bottom_row_widget.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget(
      {super.key,
      required this.onHorizontalScroll,
      required this.movie,
      required this.getTrailerId,
      required this.isMovieIdAndVerticalIndexAreEqual});

  final Function onHorizontalScroll;
  final IMovie movie;
  final Function getTrailerId;
  final bool isMovieIdAndVerticalIndexAreEqual;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {
  late int trailerId;
  @override
  void initState() {
    log('INIT TRAILER LIST ${widget.movie.title}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    log('CHANGE TRAILER LIST ${widget.movie.title}');
    trailerId = widget.getTrailerId(widget.movie.documentId);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TrailersListWidget oldWidget) {
    log('UPDATE TRAILER LIST ${widget.movie.title}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      dragStartBehavior: DragStartBehavior.down,
      controller: PageController(viewportFraction: 0.8, initialPage: trailerId),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              Expanded(
                child: VideoWidget(
                  videoURL: widget.movie.trailer[index][trailerURL],
                  isMovieIdAndVerticalIndexAreEqual:
                      widget.isMovieIdAndVerticalIndexAreEqual,
                  isTrailerIdAndHorizontalIndexAreEqual: index == trailerId,
                ),
              ),
              widget.isMovieIdAndVerticalIndexAreEqual
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: BottomRowWidget(
                        currentTrailerId: index,
                        trailer: widget.movie.trailer,
                      ),
                    )
                  : Container()
            ],
          );
        },
        childCount: widget.movie.trailer.length,
      ),
      onPageChanged: (value) {
        widget.onHorizontalScroll(value, widget.movie.documentId);
        setState(() {
          trailerId = value;
        });
      },
      scrollDirection: Axis.horizontal,
    );
  }

  @override
  void dispose() {
    log('DISPOSE TRAILER LIST ${widget.movie.title}');
    super.dispose();
  }
}
