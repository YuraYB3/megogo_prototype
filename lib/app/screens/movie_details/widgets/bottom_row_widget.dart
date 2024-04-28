import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

class BottomRowWidget extends StatefulWidget {
  const BottomRowWidget({
    super.key,
    required this.currentTrailerId,
    required this.listLength,
  });

  final int currentTrailerId;
  final int listLength;

  @override
  State<BottomRowWidget> createState() => _BottomRowWidgetState();
}

class _BottomRowWidgetState extends State<BottomRowWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.listLength, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  height: 40,
                  width: 25,
                  decoration: BoxDecoration(
                      color: widget.currentTrailerId == index
                          ? secondaryColor
                          : Colors.grey),
                  child: Container()),
            ),
          );
        }),
      ),
    );
  }
}
