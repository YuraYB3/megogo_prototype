import 'dart:developer';

import 'package:video_player/video_player.dart';

import 'ivideo_player_controllers__util.dart';

class VideoPlayerControllersUtil implements IVideoPlayerControllersUtil {
  List<VideoPlayerController> _videoControllers = [];

  final int _maxQuantityOfControllers = 6;

  VideoPlayerControllersUtil() {
    _initControllers();
  }

  void _initControllers() {
    log('INIT CONTROLLERS');
    _videoControllers = List.generate(
      _maxQuantityOfControllers,
      (index) => VideoPlayerController.networkUrl(
        Uri.parse(''),
      ),
    );
  }

  @override
  VideoPlayerController setAndGetController(String videoURL) {
    log("SET");
    VideoPlayerController controller =
        _videoControllers.firstWhere((element) => element.dataSource.isEmpty);
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));
    return controller;
  }

  @override
  void clearController({required VideoPlayerController controller}) {
    log('CLEAR CONTROLLER');
    _videoControllers.remove(controller);
  }

  @override
  void disposeControllers() {
    for (var element in _videoControllers) {
      element.dispose();
    }
  }
}
