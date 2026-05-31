import 'package:flutter/material.dart';

import 'ux_tokens.dart';

final class SafeScrollable extends StatelessWidget {
  const SafeScrollable({
    super.key,
    required this.child,
    this.bottomAction,
    this.padding = AppSpacing.screenPadding,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  });

  final Widget child;
  final Widget? bottomAction;
  final EdgeInsetsGeometry padding;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool safeAreaTop;
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
