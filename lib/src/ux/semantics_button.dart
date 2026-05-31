import 'package:flutter/widgets.dart';

import 'ux_assert.dart';

final class SemanticsButton extends StatelessWidget {
  const SemanticsButton({
    super.key,
    required this.label,
    required this.child,
    this.onTap,
    this.enabled = true,
  });

  final String label;
  final Widget child;
  final VoidCallback? onTap;
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
