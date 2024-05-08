import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerState { loading, readyToWork, playing, pause }

class VideoPlayerHandler extends ChangeNotifier {
  final VideoPlayerController _videoController;

  VideoPlayerController get videoController => _videoController;

  VideoPlayerState _videoPlayerState = VideoPlayerState.loading;
  VideoPlayerState get videoPlayerState => _videoPlayerState;

  VideoPlayerHandler({required VideoPlayerController controller})
      : _videoController = controller;

  Future<void> initializeVideoController({required String videoURL}) async {
    _videoPlayerState = VideoPlayerState.loading;
    notifyListeners();
    await _videoController.initialize();
    _videoPlayerState = VideoPlayerState.readyToWork;
  }

  void playVideo() {
    _videoController.play();
    _videoController.setLooping(true);
    _videoPlayerState = VideoPlayerState.playing;
    notifyListeners();
  }

  void pauseVideo() {
    _videoPlayerState = VideoPlayerState.pause;
    _videoController.pause();
    notifyListeners();
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
      case VideoPlayerState.readyToWork:
      default:
        break;
    }
  }
}
