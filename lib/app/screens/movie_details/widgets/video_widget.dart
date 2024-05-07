import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/utils/ivideo_player_controllers__util.dart';
import 'package:megogo_prototype/app/utils/video_player_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget(
      {super.key,
      required this.videoURL,
      required this.isMovieIdAndVerticalIndexAreEqual,
      required this.isTrailerIdAndHorizontalIndexAreEqual,
      required this.videoService});
  final String videoURL;
  final bool isMovieIdAndVerticalIndexAreEqual;
  final bool isTrailerIdAndHorizontalIndexAreEqual;
  final IVideoPlayerControllersUtil videoService;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerHandler videoPlayerUtil;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    VideoPlayerController? controller = widget.videoService.setAndGetController(widget.videoURL);
    videoPlayerUtil = VideoPlayerHandler(controller: controller);
    videoPlayerUtil
        .initializeVideoController(videoURL: widget.videoURL)
        .then((_) {
      if (widget.isMovieIdAndVerticalIndexAreEqual &&
          widget.isTrailerIdAndHorizontalIndexAreEqual) {
        videoPlayerUtil.playVideo();
        setState(() {});
      } else {}
    });
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      if (widget.isMovieIdAndVerticalIndexAreEqual &&
          widget.isTrailerIdAndHorizontalIndexAreEqual) {
        videoPlayerUtil.playVideo();
      } else {
        videoPlayerUtil.pauseVideo();
      }
    });
  }

  @override
  void dispose() {
    widget.videoService
        .clearController(controller: videoPlayerUtil.videoController);
    videoPlayerUtil.videoController.dispose();
    super.dispose();
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
                    setState(() {
                      videoPlayerUtil.onPlayButtonClicked();
                    });
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
}
