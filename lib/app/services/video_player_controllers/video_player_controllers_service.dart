import 'dart:developer';

import 'package:video_player/video_player.dart';

import 'ivideo_player_controllers__service.dart';

class VideoPlayerControllersService implements IVideoPlayerControllersService {
  List<VideoPlayerController> _videoControllers = [];

  final int _maxQuantityOfControllers = 6;

  VideoPlayerControllersService() {
    _setDefaultURLForControllers();
  }

  void _setDefaultURLForControllers() {
    log('INIT CONTROLLERS');
    _videoControllers = List.generate(
      _maxQuantityOfControllers,
      (index) => VideoPlayerController.networkUrl(
        Uri.parse(''),
      ),
    );
  }

  @override
  VideoPlayerController getController(String videoURL) {
    log("GET");
    int emptyIndex = _videoControllers.indexWhere(
      (element) => element.dataSource.isEmpty,
    );
    emptyIndex = _checkIndex(emptyIndex);
    log("$emptyIndex GET");
    _videoControllers[emptyIndex] = _prepareVideoController(videoURL);
    _replaceControllerInVideoControllersList(emptyIndex, _videoControllers[emptyIndex]);
    return _videoControllers[emptyIndex];
  }

  @override
  void clearController({required VideoPlayerController controller}) {
    log('CLEAR CONTROLLER');
    int index =
        _videoControllers.indexWhere((element) => element == controller);
    index = _checkIndex(index);
    log('CLEAR $index');
    _replaceControllerInVideoControllersList(
        index, _prepareVideoController(''));
    controller.dispose();
  }

  void _replaceControllerInVideoControllersList(
      int index, VideoPlayerController controller) {
    _videoControllers[index] = controller;
  }

  int _checkIndex(int index) => index != -1 ? index : 0;

  VideoPlayerController _prepareVideoController(String videoURL) {
    return VideoPlayerController.networkUrl(Uri.parse(videoURL));
  }

}
