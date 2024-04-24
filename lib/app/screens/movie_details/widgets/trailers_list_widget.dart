// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrailersListWidget extends StatefulWidget {
  const TrailersListWidget(
      {super.key,
      required this.trailersList,
      required this.onHorizontalScroll});
  final List<dynamic> trailersList;
  final Function(int) onHorizontalScroll;

  @override
  State<TrailersListWidget> createState() => _TrailersListState();
}

class _TrailersListState extends State<TrailersListWidget> {

  List<VideoPlayerController> controllers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final controllerCount = widget.trailersList.length;

    controllers = List.generate(
      controllerCount,
      (index) => VideoPlayerController.networkUrl(
          Uri.parse(widget.trailersList[index])),
    );
    _initialize();
  }

  Future<void> _initialize() async {
    for (final controller in controllers) {
      await controller.initialize();
    }
    controllers.first.play();
    _isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    for (var element in controllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          
          color: Colors.teal,
        ),
      );
    }
    return PageView.builder(
      onPageChanged: (value) {
        print('changed');
        for (int i = 0; i< controllers.length; i++ ) {
          if (i==value) {
            controllers[i].play();
          }
          else{
            controllers[i].pause();
          }
        }
        widget.onHorizontalScroll(value);
      },
      itemCount: widget.trailersList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controllers[index].play();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: controllers[index].value.aspectRatio,
              child: VideoPlayer(controllers[index]),
            ),
          ),
        );
      },
    );
  }
}
