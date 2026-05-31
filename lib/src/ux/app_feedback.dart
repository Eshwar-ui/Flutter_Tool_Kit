import 'package:flutter/material.dart';

/// The semantic kind of user feedback, used to color snack bars and banners.
enum AppFeedbackType {
  /// A successful or positive outcome.
  success,

  /// An error or failure.
  error,

  /// Neutral, informational feedback.
  info,

  /// A caution or warning.
  warning,
}

/// Static helpers for showing themed [SnackBar] feedback by [AppFeedbackType].
abstract final class AppSnack {
  /// Shows a snack bar with [message], colored according to [type].
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

  /// Shows a success-styled snack bar with [message].
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

  /// Shows an error-styled snack bar with [message].
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

/// An inline, dismissible feedback banner colored by [AppFeedbackType], with
/// optional leading icon and action.
final class AppBanner extends StatelessWidget {
  /// Creates a feedback banner.
  const AppBanner({
    super.key,
    required this.message,
    this.type = AppFeedbackType.info,
    this.leading,
    this.action,
    this.onDismissed,
  });

  /// The message to display.
  final String message;

  /// The feedback kind that determines the banner's colors.
  final AppFeedbackType type;

  /// An optional widget (e.g. an icon) shown before the message.
  final Widget? leading;

  /// An optional action widget shown after the message.
  final Widget? action;

  /// Called when the dismiss button is pressed; the button is hidden when
  /// `null`.
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
