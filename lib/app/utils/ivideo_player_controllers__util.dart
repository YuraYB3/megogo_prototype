import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerControllersUtil {
  VideoPlayerController setAndGetController(String videoURL);
  void clearController({required VideoPlayerController controller});
  void disposeControllers();
}
