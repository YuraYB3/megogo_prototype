import 'package:flutter/material.dart';

class BottomRowWidget extends StatelessWidget {
  const BottomRowWidget({
    super.key,
    required this.currentHorizontalIndex,
    required this.listLength,
  });

  final int currentHorizontalIndex;
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
              child: CircleAvatar(
                radius: currentHorizontalIndex == index ? 8 : 5,
                backgroundColor:
                    currentHorizontalIndex == index ? Colors.teal: Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }
}
