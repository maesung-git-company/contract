import 'dart:async';

import 'package:flutter/cupertino.dart';

class SwipeableHorizontal extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;
  final double sensitivity;

  SwipeableHorizontal({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.sensitivity = 0.0,
  });

  @override
  State<SwipeableHorizontal> createState() => _SwipeableHorizontalState();
}

class _SwipeableHorizontalState extends State<SwipeableHorizontal> {
  bool enabled = true;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        timer?.cancel();
        timer = Timer(Duration(milliseconds: 10), () { enabled = true; });

        if (!enabled) return;

        if (details.delta.dx < -widget.sensitivity) {
          widget.onSwipeRight();
        } else if (details.delta.dx > widget.sensitivity) {
          widget.onSwipeLeft();
        } else {
          return;
        }

        enabled = false;
      },
      child: widget.child,
    );
  }
}
