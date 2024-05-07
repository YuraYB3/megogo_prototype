import 'dart:developer';

import 'package:video_player/video_player.dart';

import 'ivideo_player_controllers__util.dart';

class VideoPlayerControllersUtil implements IVideoPlayerControllersUtil {
  List<VideoPlayerController> _videoControllers = [];

  final int _maxQuantityOfControllers = 8;

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
    int emptyControllerIndex = _videoControllers.indexWhere(
      (element) => element.dataSource.isEmpty,
    );
    log("INDEX $emptyControllerIndex");
    VideoPlayerController videoPlayerController =
        _videoControllers[emptyControllerIndex];
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoURL));
    _videoControllers[emptyControllerIndex] = videoPlayerController;
    return videoPlayerController;
  }

  @override
  void clearController({required VideoPlayerController controller}) {
    log('CLEAR CONTROLLER');
    _videoControllers[
            _videoControllers.indexWhere((element) => element == controller)] =
        VideoPlayerController.networkUrl(Uri.parse(''));
  }

  @override
  void disposeControllers() {
    for (var element in _videoControllers) {
      element.dispose();
    }
  }
}
