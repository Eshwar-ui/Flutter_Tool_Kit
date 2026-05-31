import 'package:flutter/material.dart';

import 'ux_tokens.dart';

/// A scrollable body that respects safe areas, adds keyboard inset padding,
/// and optionally pins a [bottomAction] below the scrolling content.
final class SafeScrollable extends StatelessWidget {
  /// Creates a safe, padded scrollable.
  const SafeScrollable({
    super.key,
    required this.child,
    this.bottomAction,
    this.padding = AppSpacing.screenPadding,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  });

  /// The scrollable content.
  final Widget child;

  /// An optional widget pinned below the scrolling area.
  final Widget? bottomAction;

  /// Padding applied around [child].
  final EdgeInsetsGeometry padding;

  /// How the scroll view dismisses the keyboard during drags.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Whether to apply safe-area padding at the top.
  final bool safeAreaTop;

  /// Whether to apply safe-area padding at the bottom.
  final bool safeAreaBottom;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      top: safeAreaTop,
      bottom: safeAreaBottom,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: keyboardDismissBehavior,
              padding: padding.add(
                EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
              ),
              child: child,
            ),
          ),
          if (bottomAction != null) bottomAction!,
        ],
      ),
    );
  }
}
