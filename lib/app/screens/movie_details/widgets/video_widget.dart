import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__service.dart';
import 'package:megogo_prototype/app/utils/video_player_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/colors_palette.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    required this.videoURL,
    required this.isMovieIdAndVerticalIndexAreEqual,
    required this.isTrailerIdAndHorizontalIndexAreEqual,
    required this.videoService,
    required this.videoPlayerHandler,
  });
  final String videoURL;
  final bool isMovieIdAndVerticalIndexAreEqual;
  final bool isTrailerIdAndHorizontalIndexAreEqual;
  final IVideoPlayerControllersService videoService;
  final VideoPlayerHandler videoPlayerHandler;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.videoPlayerHandler
        .initializeVideoController(
      videoPlayerController: widget.videoService.getController(widget.videoURL),
    )
        .then(
      (value) {
        _checkShouldVideoPlay();
      },
    );
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (oldWidget.isTrailerIdAndHorizontalIndexAreEqual !=
                widget.isTrailerIdAndHorizontalIndexAreEqual ||
            oldWidget.isMovieIdAndVerticalIndexAreEqual !=
                widget.isMovieIdAndVerticalIndexAreEqual) {
          _checkShouldVideoPlay();
        } else {}
      },
    );
  }

  @override
  void dispose() {
    widget.videoService
        .clearController(controller: widget.videoPlayerHandler.videoController);
    super.dispose();
  }

  void _checkShouldVideoPlay() {
    if (widget.isMovieIdAndVerticalIndexAreEqual &&
        widget.isTrailerIdAndHorizontalIndexAreEqual) {
      widget.videoPlayerHandler.playVideo();
    } else {
      widget.videoPlayerHandler.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.videoPlayerHandler.videoPlayerState) {
      case VideoPlayerState.loading:
        return const LoadingWidget();
      case VideoPlayerState.playing:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(
                widget.videoPlayerHandler.videoController,
              ),
              IconButton(
                onPressed: () async {
                  widget.videoPlayerHandler.onPlayButtonClicked();
                },
                icon: Icon(
                  Icons.pause,
                  size: 72,
                  color: Colors.white.withOpacity(0),
                ),
              ),
            ],
          ),
        );
      case VideoPlayerState.pause:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(
                widget.videoPlayerHandler.videoController,
              ),
              IconButton(
                onPressed: () async {
                  widget.videoPlayerHandler.onPlayButtonClicked();
                },
                icon: Icon(Icons.play_arrow, size: 72, color: secondaryColor),
              ),
            ],
          ),
        );
      default:
        return const Text('data');
    }
  }
}
