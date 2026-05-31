import 'package:flutter/material.dart';

import 'validation_message.dart';

/// Wraps a custom input [child] with a consistent label, required marker,
/// hint, supporting/error text, and character counter layout.
///
/// Use it to give bespoke input widgets the same surrounding chrome as
/// standard form fields.
final class AppTextFieldShell extends StatelessWidget {
  /// Creates a text-field shell around [child].
  const AppTextFieldShell({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.counterText,
    this.isRequired = false,
    this.spacing = 6,
  });

  /// The input widget being wrapped.
  final Widget child;

  /// An optional label shown above the input.
  final String? label;

  /// An optional hint shown below the input when there is no supporting text.
  final String? hint;

  /// An optional error message; takes precedence over [helperText].
  final String? errorText;

  /// Optional supporting text shown below the input.
  final String? helperText;

  /// Optional counter text (e.g. character count) shown below the input.
  final String? counterText;

  /// Whether to append a required marker (`*`) to the label.
  final bool isRequired;

  /// Vertical spacing between the label, input, and supporting text.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final String? supportingText = errorText ?? helperText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label!,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
            ],
          ),
          SizedBox(height: spacing),
        ],
        child,
        if (hint != null && supportingText == null) ...<Widget>[
          SizedBox(height: spacing),
          Text(
            hint!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (supportingText != null || counterText != null) ...<Widget>[
          SizedBox(height: spacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: supportingText == null
                    ? const SizedBox.shrink()
                    : ValidationMessage(
                        supportingText,
                        isError: errorText != null,
                      ),
              ),
              if (counterText != null) ...<Widget>[
                const SizedBox(width: 12),
                Text(
                  counterText!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
