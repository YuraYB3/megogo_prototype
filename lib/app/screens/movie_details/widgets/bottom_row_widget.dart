import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

class BottomRowWidget extends StatelessWidget {
  const BottomRowWidget({
    super.key,
    required this.currentTrailerId,
    required this.listLength,
  });

  final int currentTrailerId;
  final int listLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(listLength, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 25,
                decoration: BoxDecoration(

                  color: currentTrailerId == index
                      ? secondaryColor
                      : Colors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
