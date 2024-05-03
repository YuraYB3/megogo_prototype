import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerUtil {
  bool get isLoading;
  bool get isVideoPlaying;
  VideoPlayerController get videoController;
  Future<void> initializeVideoController({required String videoURL});
  void playVideo();
  void pauseVideo();
}
