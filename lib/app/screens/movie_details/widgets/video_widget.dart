import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__util.dart';
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
  final IVideoPlayerControllersService videoService;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerHandler videoPlayerUtil;
  @override
  void initState() {
    super.initState();
    VideoPlayerController controller =
        widget.videoService.getController(widget.videoURL);
    videoPlayerUtil = VideoPlayerHandler(controller: controller);
    videoPlayerUtil.initializeVideoController(videoURL: widget.videoURL);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkShouldVideoPlay();
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkShouldVideoPlay();
  }

  @override
  void dispose() {
    widget.videoService
        .clearController(controller: videoPlayerUtil.videoController);
    super.dispose();
  }

  void _checkShouldVideoPlay() {
    if (widget.isMovieIdAndVerticalIndexAreEqual &&
        widget.isTrailerIdAndHorizontalIndexAreEqual) {
      videoPlayerUtil.playVideo();
    } else {
      videoPlayerUtil.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (videoPlayerUtil.videoPlayerState) {
      case VideoPlayerState.loading:
        return const LoadingWidget();
      default:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(
                videoPlayerUtil.videoController,
              ),
              IconButton(
                onPressed: () async {
                  videoPlayerUtil.onPlayButtonClicked();
                },
                icon: videoPlayerUtil.videoPlayerState == VideoPlayerState.pause
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
}
