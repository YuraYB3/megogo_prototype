import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/video_widget.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__util.dart';
import 'package:megogo_prototype/data/movie/movie_keys.dart';
import 'package:megogo_prototype/domain/movie/imovie.dart';

import 'bottom_thumbnails_widget.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget(
      {super.key,
      required this.onHorizontalScroll,
      required this.movie,
      required this.getTrailerId,
      required this.isMovieIdAndVerticalIndexAreEqual,
      required this.videoService});

  final Function onHorizontalScroll;
  final IMovie movie;
  final Function getTrailerId;
  final IVideoPlayerControllersService videoService;
  final bool isMovieIdAndVerticalIndexAreEqual;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {
  @override
  void initState() {
    log('INIT TRAILER LIST ${widget.movie.title}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    log('CHANGE TRAILER LIST ${widget.movie.title}');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TrailersListWidget oldWidget) {
    log('UPDATE TRAILER LIST ${widget.movie.title}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSE TRAILER LIST ${widget.movie.title}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int trailerId = widget.getTrailerId(widget.movie.documentId);
    PageController pageController =
        PageController(viewportFraction: 0.8, initialPage: trailerId);
    return PageView.custom(
      dragStartBehavior: DragStartBehavior.down,
      controller: pageController,
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              Expanded(
                child: widget.isMovieIdAndVerticalIndexAreEqual ||
                        index == trailerId
                    ? VideoWidget(
                        videoService: widget.videoService,
                        videoURL: widget.movie.trailer[index][trailerURL],
                        isMovieIdAndVerticalIndexAreEqual:
                            widget.isMovieIdAndVerticalIndexAreEqual,
                        isTrailerIdAndHorizontalIndexAreEqual:
                            index == trailerId,
                      )
                    : CachedImageWidget(
                        imageUrl: widget.movie.trailer[index][trailerThumbnail],
                        height: double.infinity,
                        width: double.infinity,
                        shape: BoxShape.rectangle),
              ),
              widget.isMovieIdAndVerticalIndexAreEqual
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: BottomThumbnailsWidget(
                          pageController: pageController,
                          onThumbnailClicked: widget.onHorizontalScroll,
                          currentTrailerId: index,
                          trailer: widget.movie.trailer,
                          documentId: widget.movie.documentId),
                    )
                  : Container()
            ],
          );
        },
        childCount: widget.movie.trailer.length,
      ),
      onPageChanged: (value) {
        widget.onHorizontalScroll(value, widget.movie.documentId);
        setState(
          () {
            trailerId = value;
          },
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
