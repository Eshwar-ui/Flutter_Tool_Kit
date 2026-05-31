import 'package:flutter/material.dart';

import 'ux_tokens.dart';

/// A safe-area-aware action bar pinned to the bottom of a screen, holding a
/// primary action and an optional secondary action with a top divider.
final class StickyBottomActionBar extends StatelessWidget {
  /// Creates a sticky bottom action bar.
  const StickyBottomActionBar({
    super.key,
    required this.child,
    this.secondary,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
    this.showDivider = true,
  });

  /// The primary action widget.
  final Widget child;

  /// An optional secondary action shown before the primary one.
  final Widget? secondary;

  /// Padding around the actions.
  final EdgeInsets padding;

  /// Whether to draw a divider along the top edge.
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
