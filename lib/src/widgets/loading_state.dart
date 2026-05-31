import 'package:flutter/material.dart';

final class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
    this.message,
    this.padding = const EdgeInsets.all(24),
    this.compact = false,
  });

  final String? message;
  final EdgeInsetsGeometry padding;
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
