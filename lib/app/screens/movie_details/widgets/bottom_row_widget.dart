import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

class BottomRowWidget extends StatefulWidget {
  const BottomRowWidget(
      {super.key,
      required this.currentTrailerId,
      required this.listLength,
      required this.movieName});

  final int currentTrailerId;
  final int listLength;
  final String movieName;

  @override
  State<BottomRowWidget> createState() => _BottomRowWidgetState();
}

class _BottomRowWidgetState extends State<BottomRowWidget> {
  @override
  void didUpdateWidget(BottomRowWidget oldWidget) {
    log('UPDATED ${widget.movieName}  BottomRowWidget  CURRENT TRAILER ID:${widget.currentTrailerId}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log('DISPOSED ${widget.movieName}  BottomRowWidget ${widget.movieName}  CURRENT TRAILER ID:${widget.currentTrailerId}');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    log('CHANGED ${widget.movieName}  BottomRowWidget ${widget.movieName}  CURRENT TRAILER ID:${widget.currentTrailerId}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log("BUILDED BOTTOM ROW WIDGET.  ${widget.movieName}  CURRENT ID:${widget.currentTrailerId}");
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.listLength, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                log('$index');
              },
              child: Container(
                height: widget.currentTrailerId == index ? 50 : 40,
                width: widget.currentTrailerId == index ? 25 : 20,
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
