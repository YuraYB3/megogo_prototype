import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
import 'package:megogo_prototype/data/movie/movie_keys.dart';

class BottomRowWidget extends StatefulWidget {
  const BottomRowWidget({
    super.key,
    required this.currentTrailerId,
    required this.trailer,
  });

  final int currentTrailerId;
  final List<dynamic> trailer;
  @override
  State<BottomRowWidget> createState() => _BottomRowWidgetState();
}

class _BottomRowWidgetState extends State<BottomRowWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BottomRowWidget oldWidget) {
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
                log('$index');
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
