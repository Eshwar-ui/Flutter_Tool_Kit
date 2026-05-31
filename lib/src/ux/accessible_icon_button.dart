import 'package:flutter/material.dart';

import 'ux_assert.dart';

/// An [IconButton] that enforces a semantic label for screen readers, making
/// icon-only controls accessible.
final class AccessibleIconButton extends StatelessWidget {
  /// Creates an accessible icon button. [semanticLabel] is required.
  const AccessibleIconButton({
    super.key,
    required this.semanticLabel,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.enabled = true,
  });

  /// The accessibility label announced by screen readers.
  final String semanticLabel;

  /// The icon widget to display.
  final Widget icon;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// The tooltip text; defaults to [semanticLabel].
  final String? tooltip;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    UxAssert.hasSemanticLabel(semanticLabel);

    return Semantics(
      button: true,
      enabled: enabled && onPressed != null,
      label: semanticLabel,
      onTap: enabled ? onPressed : null,
      child: IconButton(
        tooltip: tooltip ?? semanticLabel,
        onPressed: enabled ? onPressed : null,
        icon: icon,
      ),
    );
  }
}
