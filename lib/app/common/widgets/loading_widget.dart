import 'package:flutter/material.dart';

import '../../theme/colors_palette.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        ),
      );
  }
}