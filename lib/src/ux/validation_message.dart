import 'package:flutter/material.dart';

final class ValidationMessage extends StatelessWidget {
  const ValidationMessage(this.message, {super.key, this.isError = true});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Text(
      message,
      style: theme.textTheme.bodySmall?.copyWith(
        color: isError ? colorScheme.error : colorScheme.onSurfaceVariant,
      ),
    );
  }
}
