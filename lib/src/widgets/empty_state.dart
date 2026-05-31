import 'package:flutter/material.dart';

final class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.action,
    this.onRetry,
    this.retryLabel = 'Retry',
    this.padding = const EdgeInsets.all(24),
    this.compact = false,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final Widget? action;
  final VoidCallback? onRetry;
  final String retryLabel;
  final EdgeInsetsGeometry padding;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double iconSize = compact ? 28 : 40;

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: iconSize, color: theme.colorScheme.outline),
              SizedBox(height: compact ? 8 : 12),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: compact
                  ? theme.textTheme.titleSmall
                  : theme.textTheme.titleMedium,
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (action != null) ...<Widget>[
              SizedBox(height: compact ? 12 : 16),
              action!,
            ] else if (onRetry != null) ...<Widget>[
              SizedBox(height: compact ? 12 : 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
