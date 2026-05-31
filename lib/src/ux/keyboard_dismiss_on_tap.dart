import 'package:flutter/widgets.dart';

final class KeyboardDismissOnTap extends StatelessWidget {
  const KeyboardDismissOnTap({
    super.key,
    required this.child,
    this.behavior = HitTestBehavior.translucent,
  });

  final Widget child;
  final HitTestBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: behavior,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
