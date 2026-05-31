import 'package:flutter/material.dart';

/// A centered error/empty placeholder with an icon, title, message, and an
/// optional retry button. Offers a [compact] variant for inline use.
final class RetryView extends StatelessWidget {
  /// Creates a retry view.
  const RetryView({
    super.key,
    required this.title,
    this.message,
    this.retryLabel = 'Retry',
    this.onRetry,
    this.icon = Icons.refresh,
    this.padding = const EdgeInsets.all(24),
    this.compact = false,
  });

  /// The headline text.
  final String title;

  /// An optional supporting message.
  final String? message;

  /// The label for the retry button.
  final String retryLabel;

  /// Called when the retry button is pressed; the button is hidden when `null`.
  final VoidCallback? onRetry;

  /// The icon shown above the title; hidden when `null`.
  final IconData? icon;

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
            if (onRetry != null) ...<Widget>[
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
