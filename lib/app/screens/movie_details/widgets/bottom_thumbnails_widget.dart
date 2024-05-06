import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
import 'package:megogo_prototype/data/movie/movie_keys.dart';

class BottomThumbnailsWidget extends StatefulWidget {
  const BottomThumbnailsWidget(
      {super.key,
      required this.currentTrailerId,
      required this.trailer,
      required this.onThumbnailClicked,
      required this.documentId,
      required this.pageController});

  final int currentTrailerId;
  final List<dynamic> trailer;
  final Function onThumbnailClicked;
  final String documentId;
  final PageController pageController;
  @override
  State<BottomThumbnailsWidget> createState() => _BottomThumbnailsWidgetState();
}

class _BottomThumbnailsWidgetState extends State<BottomThumbnailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BottomThumbnailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.trailer.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                widget.onThumbnailClicked(index, widget.documentId);
              },
              child: CachedImageWidget(
                height: widget.currentTrailerId == index ? 70 : 50,
                width: widget.currentTrailerId == index ? 35 : 25,
                shape: BoxShape.rectangle,
                imageUrl: widget.trailer[index][trailerThumbnail],
              ),
            ),
          );
        }),
      ),
    );
  }
}
