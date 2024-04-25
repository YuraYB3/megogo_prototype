// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerUtil extends ChangeNotifier {
  late List<VideoPlayerController> controllers;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isVideoPlaying = false;
  bool get isVideoPlaying => _isVideoPlaying;

  Future<void> initializeControllers(
      {required List<dynamic> listOfVideos, required Function setState}) async {
    final int controllerCount = listOfVideos.length;
    controllers = List.generate(
      controllerCount,
      (index) =>
          VideoPlayerController.networkUrl(Uri.parse(listOfVideos[index])),
    );
    await Future.wait(
      controllers.map(
        (controller) => controller.initialize(),
      ),
    );
    _isLoading = false;
    setState();
  }

  void disposeControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
    print('we here');
  }

  void handlePageChanged(int value) {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].pause();
    }
    _isVideoPlaying = false;
  }

  void onPlayButtonClicked(int index, bool isVideoPlaying, Function setState) {
    if (isVideoPlaying) {
      controllers[index].pause();
    } else {
      controllers[index].play();
      controllers[index].setLooping(true);
    }
    _isVideoPlaying = !_isVideoPlaying;
    setState();
  }
}
