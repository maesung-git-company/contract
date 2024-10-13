
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
  final int? retryAfterS;

  SkeletonSafe({
    super.key,
    required this.child,
    required this.inspectList,

    this.onDisabled,
    this.retryAfterS,

    this.pseudoLayout,
  });

  @override
  State<SkeletonSafe> createState() => _SkeletonSafeState();
}

class _SkeletonSafeState extends State<SkeletonSafe> {
  Timer? onDisableRetryer;

  @override
  Widget build(BuildContext context) {
    bool skeletonizerEnabled = widget.inspectList.contains(null);

    if (skeletonizerEnabled && widget.onDisabled != null) {
      widget.onDisabled!();
      if (widget.retryAfterS != null && onDisableRetryer == null) {
        onDisableRetryer = Timer.periodic(
            Duration(seconds: widget.retryAfterS!),
            (Timer timer) { print(widget.child); widget.onDisabled!(); }
        );
      }
    }

    if (!skeletonizerEnabled) {
      onDisableRetryer?.cancel();
    }

    Widget child = skeletonizerEnabled && (widget.pseudoLayout != null)
        ? widget.pseudoLayout!
        : widget.child;

    return Skeletonizer(
        enabled: skeletonizerEnabled,
        child: child
    );
  }

  @override
  void dispose() {
    onDisableRetryer?.cancel();
    super.dispose();
  }
}

