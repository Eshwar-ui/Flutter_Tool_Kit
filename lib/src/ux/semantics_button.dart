import 'package:flutter/widgets.dart';

import 'ux_assert.dart';

/// Annotates an arbitrary [child] as a button for screen readers, enforcing a
/// semantic label. Use it to make custom tappable widgets accessible.
final class SemanticsButton extends StatelessWidget {
  /// Creates a semantics button wrapper. [label] is required.
  const SemanticsButton({
    super.key,
    required this.label,
    required this.child,
    this.onTap,
    this.enabled = true,
  });

  /// The accessibility label announced by screen readers.
  final String label;

  /// The widget presented as a button.
  final Widget child;

  /// Called when the button is activated.
  final VoidCallback? onTap;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    UxAssert.hasSemanticLabel(label);

    return Semantics(
      button: true,
      enabled: enabled && onTap != null,
      label: label,
      onTap: enabled ? onTap : null,
      child: child,
    );
  }
}
