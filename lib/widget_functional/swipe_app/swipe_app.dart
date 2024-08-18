import 'package:contract/widget_functional/swipeable_horizontal/swipeable_horizontal.dart';
import 'package:flutter/cupertino.dart';

class SwipeApp extends StatefulWidget {
  final List<Widget> pages;
  final int initialPageIndex;

  const SwipeApp({
    super.key,
    required this.pages,
    required this.initialPageIndex,
  });

  @override
  State<SwipeApp> createState() => _TestPageState();
}

class _TestPageState extends State<SwipeApp> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex;
  }

  void updateView() {

  }

  @override
  Widget build(BuildContext context) {
    return SwipeableHorizontal( // todo perhaps swipe animation?
      sensitivity: 8.0,  // todo investigate if its ok
      onSwipeLeft: () => {
        setState(() {
          int idx = currentPageIndex - 1;
          idx = idx >= 0 ? idx : 0;
          currentPageIndex = idx;
        })
      },
      onSwipeRight: () => {
        setState(() {
          int idx = currentPageIndex + 1;
          idx = idx < widget.pages.length ? idx : widget.pages.length - 1;
          currentPageIndex = idx;
        })
      },
      child: widget.pages[currentPageIndex]
    );
  }
}

