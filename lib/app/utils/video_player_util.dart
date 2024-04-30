// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerUtil extends ChangeNotifier {
  late List<VideoPlayerController> controllers;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isVideoPlaying = false;
  bool get isVideoPlaying => _isVideoPlaying;

  Future<void> initializeVideoControllers(
      {required List<dynamic> listOfURLs}) async {
    controllers = List.generate(
      listOfURLs.length,
      (index) => VideoPlayerController.networkUrl(
        Uri.parse(
          listOfURLs[index],
        ),
      ),
    );

    await Future.wait(
      controllers.map(
        (controller) => controller.initialize(),
      ),
    );

    _isLoading = false;
  }

  void disposeControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  void handlePageChanging() {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].pause();
    }
    _isVideoPlaying = false;
  }

  Future<void> onPlayButtonClicked(int index, bool isVideoPlaying) async {
    if (isVideoPlaying) {
      controllers[index].pause();
    } else {
      controllers[index].play();
      controllers[index].setLooping(true);
    }
    _isVideoPlaying = !_isVideoPlaying;
  }
}
