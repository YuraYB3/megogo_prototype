import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerUtil extends ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  bool _isVideoPlaying = true;
  late Future _futureVideoPlayer;
  Future get futureVideoPlayer => _futureVideoPlayer;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final String videoUrl;

  VideoPlayerUtil({required this.videoUrl});

  Future<void> initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _futureVideoPlayer = _videoPlayerController.initialize();
    _isInitialized = true;
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    notifyListeners();
  }

  void disposeVideoPlayer() {
    _isInitialized = false;
    _videoPlayerController.dispose();
  }

  void onVideoTaped() {
    if (_isVideoPlaying) {
      _videoPlayerController.pause();
      _isVideoPlaying = false;
      notifyListeners();
    } else {
      _videoPlayerController.play();
      _isVideoPlaying = true;
      notifyListeners();
    }
  }
}
