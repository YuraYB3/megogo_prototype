import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/services/video_player_controllers/ivideo_player_controllers__service.dart';
import 'package:megogo_prototype/app/utils/video_player_handler.dart';
import 'package:video_player/video_player.dart';

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
      (_) {
        _checkShouldVideoPlay();
      },
    );
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (oldWidget.isTrailerIdAndHorizontalIndexAreEqual !=
                widget.isTrailerIdAndHorizontalIndexAreEqual ||
            oldWidget.isMovieIdAndVerticalIndexAreEqual !=
                widget.isMovieIdAndVerticalIndexAreEqual) {
          _checkShouldVideoPlay();
        }
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
      case VideoPlayerState.readyToWork:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTapDown: (_) {
              widget.videoPlayerHandler.pauseVideo();
            },
            onTapUp: (_) {
              widget.videoPlayerHandler.playVideo();
            },
            child: VideoPlayer(
              widget.videoPlayerHandler.videoController,
            ),
          ),
        );
    }
  }
}
