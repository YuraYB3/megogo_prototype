import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/video_player_util.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  final VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  VideoScreen({
    super.key,
    required this.url,
  });

  @override
  State<VideoScreen> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoScreen> {
  @override
  void initState() {
    widget.videoPlayerUtil.initVideoPlayer(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerUtil.disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.videoPlayerUtil.isInitialized
        ? FutureBuilder(
            future: widget.videoPlayerUtil.futureVideoPlayer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    widget.videoPlayerUtil.onVideoTaped();
                  },
                  child: SizedBox(
                    child: VideoPlayer(
                        widget.videoPlayerUtil.videoPlayerController),
                  ),
                );
              }
            },
          )
        : Container(
            color: Colors.black,
            height: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
