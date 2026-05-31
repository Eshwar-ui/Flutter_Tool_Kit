import 'package:flutter/material.dart';

import 'ux_assert.dart';

final class AccessibleIconButton extends StatelessWidget {
  const AccessibleIconButton({
    super.key,
    required this.semanticLabel,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.enabled = true,
  });

  final String semanticLabel;
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
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
