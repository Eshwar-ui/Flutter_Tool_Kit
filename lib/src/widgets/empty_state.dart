import 'package:flutter/material.dart';

/// A centered placeholder for empty or error states, with an icon, title,
/// message, and either a custom action or a built-in retry button.
final class EmptyState extends StatelessWidget {
  /// Creates an empty-state placeholder.
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

  /// The headline text.
  final String title;

  /// An optional supporting message.
  final String? message;

  /// An optional icon shown above the title.
  final IconData? icon;

  /// A custom action widget; takes precedence over the retry button.
  final Widget? action;

  /// Called when the built-in retry button is pressed.
  final VoidCallback? onRetry;

  /// The label for the built-in retry button.
  final String retryLabel;

  /// Padding around the content.
  final EdgeInsetsGeometry padding;

  /// Whether to use the smaller, inline-friendly layout.
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
