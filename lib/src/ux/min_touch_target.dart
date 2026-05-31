import 'package:flutter/widgets.dart';

import 'ux_tokens.dart';

final class MinTouchTarget extends StatelessWidget {
  const MinTouchTarget({
    super.key,
    required this.child,
    this.minSize = AppTouchTargets.minSize,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final Size minSize;
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
