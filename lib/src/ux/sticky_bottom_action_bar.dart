import 'package:flutter/material.dart';

import 'ux_tokens.dart';

final class StickyBottomActionBar extends StatelessWidget {
  const StickyBottomActionBar({
    super.key,
    required this.child,
    this.secondary,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
    this.showDivider = true,
  });

  final Widget child;
  final Widget? secondary;
  final EdgeInsets padding;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: showDivider
            ? Border(top: BorderSide(color: theme.colorScheme.outlineVariant))
            : null,
      ),
      child: SafeArea(
        top: false,
        minimum: padding,
        child: Row(
          children: <Widget>[
            if (secondary != null) ...<Widget>[
              Expanded(child: secondary!),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
