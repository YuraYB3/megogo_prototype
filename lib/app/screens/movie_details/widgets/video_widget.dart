import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/utils/video_player_util.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    required this.videoURL,
    required this.isMovieIdAndVerticalIndexAreEqual,
    required this.isTrailerIdAndHorizontalIndexAreEqual,
  });
  final String videoURL;
  final bool isMovieIdAndVerticalIndexAreEqual;
  final bool isTrailerIdAndHorizontalIndexAreEqual;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  @override
  void initState() {
    videoPlayerUtil
        .initializeVideoController(videoURL: widget.videoURL)
        .then((_) {
      if (widget.isMovieIdAndVerticalIndexAreEqual &&
          widget.isTrailerIdAndHorizontalIndexAreEqual) {
        videoPlayerUtil.playVideo();
      } else {}
      setState(
        () {},
      );
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (widget.isMovieIdAndVerticalIndexAreEqual &&
        widget.isTrailerIdAndHorizontalIndexAreEqual) {
      videoPlayerUtil.playVideo();
    } else {
      videoPlayerUtil.pauseVideo();
    }
    setState(() {});

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerUtil.isLoading
        ? const LoadingWidget()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(
                  videoPlayerUtil.videoController,
                ),
                IconButton(
                  onPressed: () async {
                    videoPlayerUtil
                        .onPlayButtonClicked(
                        )
                        .then(
                          (value) => setState(() {}),
                        );
                  },
                  icon: !videoPlayerUtil.isVideoPlaying
                      ? Icon(Icons.play_arrow, size: 72, color: secondaryColor)
                      : Icon(
                          Icons.pause,
                          size: 72,
                          color: Colors.white.withOpacity(0),
                        ),
                ),
              ],
            ),
          );
  }

  @override
  void dispose() {
    videoPlayerUtil.videoController.dispose();
    super.dispose();
  }
}
