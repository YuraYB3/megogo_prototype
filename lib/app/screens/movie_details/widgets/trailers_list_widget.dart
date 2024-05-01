import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/bottom_row_widget.dart';
import 'package:megogo_prototype/app/utils/video_player_util.dart';
import 'package:megogo_prototype/domain/movie/imovie.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget({
    super.key,
    required this.onHorizontalScroll,
    required this.horizontalPageController,
    required this.movie,
  });

  final Function onHorizontalScroll;
  final PageController horizontalPageController;
  final IMovie movie;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {
  final VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  @override
  void initState() {
    super.initState();
    videoPlayerUtil
        .initializeVideoControllers(
          listOfURLs: widget.movie.trailer,
        )
        .then(
          (value) => setState(
            () {},
          ),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TrailersListWidget oldWidget) {
    videoPlayerUtil.handlePageChanging();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    videoPlayerUtil.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Is  trailers for movie ${widget.movie.title} loading ${videoPlayerUtil.isLoading}');

    return videoPlayerUtil.isLoading
        ? CachedImageWidget(
            imageUrl: widget.movie.poster,
            height: double.infinity,
            shape: BoxShape.rectangle,
            width: double.infinity)
        : PageView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(
                              videoPlayerUtil.controllers[index],
                            ),
                            IconButton(
                              onPressed: () async {
                                videoPlayerUtil
                                    .onPlayButtonClicked(
                                      index,
                                      videoPlayerUtil.isVideoPlaying,
                                    )
                                    .then(
                                      (value) => setState(() {}),
                                    );
                              },
                              icon: !videoPlayerUtil.isVideoPlaying
                                  ? Icon(Icons.play_arrow,
                                      size: 72, color: secondaryColor)
                                  : Icon(
                                      Icons.pause,
                                      size: 72,
                                      color: Colors.white.withOpacity(0),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BottomRowWidget(
                        currentTrailerId: index,
                        trailer: widget.movie.trailer,
                      )
                    ],
                  ),
                );
              },
              childCount: widget.movie.trailer.length,
            ),
            onPageChanged: (value) {
              widget.onHorizontalScroll(value, widget.movie.documentId);
            },
            controller: widget.horizontalPageController,
            scrollDirection: Axis.horizontal,
          );
  }
}
