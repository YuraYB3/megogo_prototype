import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/movie_details/widgets/bottom_row_widget.dart';
import 'package:megogo_prototype/app/utils/video_player_util.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget({
    super.key,
    required this.trailersURLs,
    required this.onHorizontalScroll,
    required this.horizontalPageController,
    required this.currentVerticalIndex,
    required this.defaultVerticalIndex,
  });
  final List<dynamic> trailersURLs;
  final Function onHorizontalScroll;
  final PageController horizontalPageController;
  final int currentVerticalIndex;
  final int defaultVerticalIndex;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {
  final VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  @override
  void initState() {
    super.initState();
    videoPlayerUtil
        .initializeControllers(
          listOfURLs: widget.trailersURLs,
        )
        .then(
          (value) => setState(
            () {},
          ),
        );
  }

  @override
  void dispose() {
    videoPlayerUtil.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerUtil.isLoading
        ? Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            ),
          )
        : PageView.builder(
            onPageChanged: (value) {
              videoPlayerUtil.handlePageChanged(value);
              widget.onHorizontalScroll(value);
            },
            controller: widget.horizontalPageController,
            itemCount: widget.trailersURLs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, horizontalIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: VideoPlayer(
                              videoPlayerUtil.controllers[horizontalIndex],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              videoPlayerUtil
                                  .onPlayButtonClicked(
                                    horizontalIndex,
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
                    widget.currentVerticalIndex == widget.defaultVerticalIndex
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              BottomRowWidget(
                                  currentHorizontalIndex: horizontalIndex,
                                  listLength: widget.trailersURLs.length),
                            ],
                          )
                        : Container()
                  ],
                ),
              );
            },
          );
  }
}
