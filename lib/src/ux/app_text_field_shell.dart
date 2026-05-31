import 'package:flutter/material.dart';

import 'validation_message.dart';

final class AppTextFieldShell extends StatelessWidget {
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

  final Widget child;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final String? counterText;
  final bool isRequired;
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
