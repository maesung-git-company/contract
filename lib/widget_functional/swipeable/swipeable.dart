import 'package:flutter/cupertino.dart';

class Swipeable extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  Swipeable({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight
  });

  @override
  State<Swipeable> createState() => _SwipeableState();
}

class _SwipeableState extends State<Swipeable> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) widget.onSwipeRight();
        if (details.delta.dx < 0) widget.onSwipeLeft();
      },
      child: widget.child,
    );
  }
}
