// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/utils/video_player_util.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget({
    super.key,
    required this.trailersList,
    required this.onHorizontalScroll,
  });
  final List<dynamic> trailersList;
  final Function(int) onHorizontalScroll;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {
  final VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  @override
  void initState() {
    super.initState();
    videoPlayerUtil.initializeControllers(
        listOfURLs: widget.trailersList,
        setState: () {
          setState(() {});
        });
  }

  @override
  void dispose() {
    videoPlayerUtil.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerUtil.isLoading) {
      return Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        ),
      );
    } else {
      return PageView.builder(
        onPageChanged: (value) {
          videoPlayerUtil.handlePageChanged(value);
          widget.onHorizontalScroll(value);
        },
        itemCount: widget.trailersList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio:
                      videoPlayerUtil.controllers[index].value.aspectRatio,
                  child: VideoPlayer(videoPlayerUtil.controllers[index]),
                ),
                IconButton(
                  onPressed: () {
                    videoPlayerUtil.onPlayButtonClicked(
                      index,
                      videoPlayerUtil.isVideoPlaying,
                      () {
                        setState(() {});
                      },
                    );
                  },
                  icon: !videoPlayerUtil.isVideoPlaying
                      ? Icon(Icons.play_arrow, size: 72, color: secondaryColor)
                      : Icon(
                          Icons.pause,
                          size: 72,
                          color: Colors.white.withOpacity(0),
                        ),
                )
              ],
            ),
          );
        },
      );
    }
  }
}
