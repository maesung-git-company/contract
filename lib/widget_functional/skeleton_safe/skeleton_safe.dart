import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';


/// if any element of this is null, returns skeleton.
/// returns the Skeletonizer widget where
/// enabled flag is false and their child is original widget.
class SkeletonSafe extends StatefulWidget {
  final Widget child;
  final List<dynamic> inspectList;

  final Widget? pseudoLayout;
  final VoidCallback? onDisabled;
  final int? reloadAfterMillisecond;
  final VoidCallback? reloadCallback;

  SkeletonSafe({
    super.key,
    required this.child,
    required this.inspectList,

    this.onDisabled,
    this.reloadAfterMillisecond,
    this.reloadCallback,

    this.pseudoLayout,
  }) {
    if ((reloadAfterMillisecond == null) ^ (reloadAfterMillisecond == null)) { // if one is null while the other isn't
      throw ArgumentError("both reloadAfterMillisecond and reloadAfterMillisecond should be provided!");
    }
  }

  @override
  State<SkeletonSafe> createState() => _SkeletonSafeState();
}

class _SkeletonSafeState extends State<SkeletonSafe> {
  @override
  Widget build(BuildContext context) {
    bool skeletonizerEnabled = widget.inspectList.contains(null);

    if (!skeletonizerEnabled) {
      if (widget.onDisabled != null) widget.onDisabled!();
      if (widget.reloadAfterMillisecond != null){
        Timer(
          Duration(milliseconds: widget.reloadAfterMillisecond!),
          widget.reloadCallback!
        );
      }
    }

    Widget child = skeletonizerEnabled && (widget.pseudoLayout != null)
        ? widget.pseudoLayout!
        : widget.child;

    return Skeletonizer(
        enabled: skeletonizerEnabled,
        child: child
    );
  }
}

