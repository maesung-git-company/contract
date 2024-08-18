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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -widget.sensitivity) widget.onSwipeRight();
        if (details.delta.dx > widget.sensitivity) widget.onSwipeLeft();
      },
      child: widget.child,
    );
  }
}
