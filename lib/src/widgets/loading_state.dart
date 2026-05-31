import 'package:flutter/material.dart';

/// A centered loading indicator with an optional message, with a [compact]
/// variant for inline use.
final class LoadingState extends StatelessWidget {
  /// Creates a loading-state placeholder.
  const LoadingState({
    super.key,
    this.message,
    this.padding = const EdgeInsets.all(24),
    this.compact = false,
  });

  /// An optional message shown beneath the indicator.
  final String? message;

  /// Padding around the content.
  final EdgeInsetsGeometry padding;

  /// Whether to use the smaller, inline-friendly layout.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double indicatorSize = compact ? 20 : 36;

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox.square(
              dimension: indicatorSize,
              child: const CircularProgressIndicator(strokeWidth: 2.5),
            ),
            if (message != null) ...<Widget>[
              SizedBox(height: compact ? 8 : 12),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
