import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerState { loading, playing, pause }

class VideoPlayerHandler extends ChangeNotifier {
  late VideoPlayerController _videoController;

  VideoPlayerController get videoController => _videoController;

  VideoPlayerState _videoPlayerState = VideoPlayerState.loading;
  VideoPlayerState get videoPlayerState => _videoPlayerState;

  Future<void> initializeVideoController(
      {required VideoPlayerController controller}) async {
    _videoController = controller;
    await _videoController.initialize();
  }

  void playVideo() {
    _videoPlayerState = VideoPlayerState.playing;
    notifyListeners();
    _videoController.play();
    _videoController.setLooping(true);
  }

  void pauseVideo() {
    _videoPlayerState = VideoPlayerState.pause;
    notifyListeners();
    _videoController.pause();
  }

  Future<void> onPlayButtonClicked() async {
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
}
