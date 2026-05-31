import 'package:flutter/widgets.dart';

/// Dismisses the on-screen keyboard when the user taps outside a focused
/// input within [child].
final class KeyboardDismissOnTap extends StatelessWidget {
  /// Creates a keyboard-dismiss-on-tap wrapper.
  const KeyboardDismissOnTap({
    super.key,
    required this.child,
    this.behavior = HitTestBehavior.translucent,
  });

  /// The subtree that listens for taps to dismiss the keyboard.
  final Widget child;

  /// How the gesture detector behaves during hit testing.
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
