import 'package:flutter/material.dart';

enum AppFeedbackType { success, error, info, warning }

abstract final class AppSnack {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    String message, {
    AppFeedbackType type = AppFeedbackType.info,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    final ThemeData theme = Theme.of(context);

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _backgroundColor(theme.colorScheme, type),
        action: action,
        duration: duration,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message, {
    SnackBarAction? action,
  }) {
    return show(
      context,
      message,
      type: AppFeedbackType.success,
      action: action,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message, {
    SnackBarAction? action,
  }) {
    return show(context, message, type: AppFeedbackType.error, action: action);
  }

  static Color _backgroundColor(ColorScheme colorScheme, AppFeedbackType type) {
    return switch (type) {
      AppFeedbackType.success => colorScheme.primary,
      AppFeedbackType.error => colorScheme.error,
      AppFeedbackType.info => colorScheme.inverseSurface,
      AppFeedbackType.warning => colorScheme.tertiary,
    };
  }
}

final class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.message,
    this.type = AppFeedbackType.info,
    this.leading,
    this.action,
    this.onDismissed,
  });

  final String message;
  final AppFeedbackType type;
  final Widget? leading;
  final Widget? action;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color backgroundColor = switch (type) {
      AppFeedbackType.success => colorScheme.primaryContainer,
      AppFeedbackType.error => colorScheme.errorContainer,
      AppFeedbackType.info => colorScheme.surfaceContainerHighest,
      AppFeedbackType.warning => colorScheme.tertiaryContainer,
    };
    final Color foregroundColor = switch (type) {
      AppFeedbackType.success => colorScheme.onPrimaryContainer,
      AppFeedbackType.error => colorScheme.onErrorContainer,
      AppFeedbackType.info => colorScheme.onSurfaceVariant,
      AppFeedbackType.warning => colorScheme.onTertiaryContainer,
    };

    return Material(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            if (leading != null) ...<Widget>[
              IconTheme(
                data: IconThemeData(color: foregroundColor),
                child: leading!,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                ),
              ),
            ),
            if (action != null) ...<Widget>[const SizedBox(width: 12), action!],
            if (onDismissed != null) ...<Widget>[
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Dismiss',
                onPressed: onDismissed,
                icon: const Icon(Icons.close),
                color: foregroundColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
