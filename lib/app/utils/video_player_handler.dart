import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerHandler extends ChangeNotifier {
  final VideoPlayerController _videoController;

  VideoPlayerController get videoController => _videoController;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isVideoPlaying = false;
  bool get isVideoPlaying => _isVideoPlaying;

  VideoPlayerHandler({required VideoPlayerController controller})
      : _videoController = controller;

  Future<void> initializeVideoController({required String videoURL}) async {
   await _videoController.initialize();
    _isLoading = false;
  }

  void playVideo() {
    _videoController.play();
    _videoController.setLooping(true);
    _isVideoPlaying = true;
  }

  void pauseVideo() {
    _videoController.pause();
    _isVideoPlaying = false;
  }

  Future<void> onPlayButtonClicked() async {
    if (isVideoPlaying) {
      pauseVideo();
    } else {
      playVideo();
    }
  }
}
