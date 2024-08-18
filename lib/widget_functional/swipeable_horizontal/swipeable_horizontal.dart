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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (!enabled) return;

        if (details.delta.dx < -widget.sensitivity) {
          widget.onSwipeRight();
        } else if (details.delta.dx > widget.sensitivity) {
          widget.onSwipeLeft();
        } else {
          return;
        }

        // lil delay after swipe
        enabled = false;
        // todo perhaps delay till input is stabilized?
        Future.delayed(const Duration(milliseconds: 300), () => {
          enabled = true
        });
      },
      child: widget.child,
    );
  }
}
