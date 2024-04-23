import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/video_player_util.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  late VideoPlayerUtil videoPlayerUtil;
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
    widget.videoPlayerUtil = VideoPlayerUtil(videoUrl: widget.url);
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerUtil.disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.videoPlayerUtil.initVideoPlayer(),
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
              child: VideoPlayer(widget.videoPlayerUtil.videoPlayerController),
            ),
          );
        }
      },
    );
  }
}
