import 'package:flutter/widgets.dart';

import 'ux_tokens.dart';

/// Ensures [child] occupies at least a minimum tappable size, meeting
/// accessibility touch-target guidelines.
final class MinTouchTarget extends StatelessWidget {
  /// Creates a minimum-touch-target wrapper.
  const MinTouchTarget({
    super.key,
    required this.child,
    this.minSize = AppTouchTargets.minSize,
    this.alignment = Alignment.center,
  });

  /// The widget to enforce a minimum size around.
  final Widget child;

  /// The minimum width and height of the touch target.
  final Size minSize;

  /// How [child] is aligned within the enforced area.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSize.width,
        minHeight: minSize.height,
      ),
      child: Align(alignment: alignment, child: child),
    );
  }
}
