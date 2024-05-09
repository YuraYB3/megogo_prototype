import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerState { loading, playing, pause }

class VideoPlayerHandler extends ChangeNotifier {
  late VideoPlayerController _videoController;

  VideoPlayerController get videoController => _videoController;

  VideoPlayerState _videoPlayerState = VideoPlayerState.loading;
  VideoPlayerState get videoPlayerState => _videoPlayerState;

  Future<void> initializeVideoController(
      {required VideoPlayerController videoPlayerController}) async {
    _videoController = videoPlayerController;
    await _videoController.initialize();
  }

  void playVideo() {
    _videoController.play();
    _videoController.setLooping(true);
    _updateVideoPlayerState(VideoPlayerState.playing);
  }

  void pauseVideo() {
    _videoController.pause();
    _updateVideoPlayerState(VideoPlayerState.pause);
  }

  void onPlayButtonClicked() {
    switch (_videoPlayerState) {
      case VideoPlayerState.pause:
        playVideo();
        break;
      case VideoPlayerState.playing:
        pauseVideo();
        break;
      case VideoPlayerState.loading:
      default:
        break;
    }
  }

  void _updateVideoPlayerState(VideoPlayerState videoPlayerState) {
    _videoPlayerState = videoPlayerState;
    notifyListeners();
  }
}
