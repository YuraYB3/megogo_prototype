import 'dart:developer';

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
  void didUpdateWidget(BottomRowWidget oldWidget) {
    log('UPDATED BottomRowWidget  CURRENT ID:${widget.currentTrailerId}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSED BottomRowWidget  CURRENT ID:${widget.currentTrailerId}');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    log('CHANGED BottomRowWidget  CURRENT ID:${widget.currentTrailerId}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log("BOTTOM ROW WIDGET. CURRENT ID:${widget.currentTrailerId}");
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
                child: Container(),
              ),
            ),
          );
        }),
      ),
    );
  }
}