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

  const SkeletonSafe({
    super.key,
    required this.inspectList,
    required this.child,
    this.pseudoLayout,
    this.onDisabled
  });

  @override
  State<SkeletonSafe> createState() => _SkeletonSafeState();
}

class _SkeletonSafeState extends State<SkeletonSafe> {
  @override
  Widget build(BuildContext context) {
    bool skeletonizerEnabled = widget.inspectList.contains(null);

    if (!skeletonizerEnabled && widget.onDisabled != null) widget.onDisabled!();

    Widget child = skeletonizerEnabled && widget.pseudoLayout != null
        ? widget.pseudoLayout!
        : widget.child;

    return Skeletonizer(
        enabled: skeletonizerEnabled,
        child: child
    );
  }
}
