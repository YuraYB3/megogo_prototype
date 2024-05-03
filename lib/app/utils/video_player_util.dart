// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/utils/ivideo_player_util.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerUtil extends ChangeNotifier implements IVideoPlayerUtil {
  late VideoPlayerController _videoController;
  @override
  VideoPlayerController get videoController => _videoController;

  bool _isLoading = true;
  @override
  bool get isLoading => _isLoading;

  bool _isVideoPlaying = false;
  @override
  bool get isVideoPlaying => _isVideoPlaying;

  @override
  Future<void> initializeVideoController({required String videoURL}) async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        videoURL,
      ),
    );
    await _videoController.initialize();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void playVideo() {
    _videoController.play();
    _videoController.setLooping(true);
    _isVideoPlaying = true;
  }

  @override
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
