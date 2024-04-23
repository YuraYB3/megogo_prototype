import 'package:flutter/material.dart';

import '../../../common/widgets/cached_image.dart';

class PosterCell extends StatelessWidget {
  const PosterCell({super.key, required this.posterUrl, required this.onCellClicked, required this.posterHeight, required this.posterWidth});

  final String posterUrl;
  final Function() onCellClicked;
  final double posterHeight;
  final double posterWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       onCellClicked();
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: CachedImageWidget(
                imageUrl: posterUrl,
                height: posterHeight,
                shape: BoxShape.rectangle,
                width: posterWidth,
              ),
            )
          ]),
    );
  }
}
