import 'package:flutter/material.dart';

/// A small text label for validation or helper messages, colored as an error
/// by default or as muted supporting text when [isError] is `false`.
final class ValidationMessage extends StatelessWidget {
  /// Creates a validation message showing [message].
  const ValidationMessage(this.message, {super.key, this.isError = true});

  /// The message text to display.
  final String message;

  /// Whether to style the text as an error (`true`) or supporting text.
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
