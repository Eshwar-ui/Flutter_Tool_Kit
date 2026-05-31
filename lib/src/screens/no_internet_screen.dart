import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

/// A ready-made screen shown when the device has no internet connection,
/// offering retry and optional open-settings actions.
final class NoInternetScreen extends StatelessWidget {
  /// Creates a no-internet screen.
  const NoInternetScreen({
    super.key,
    this.title = 'No internet connection',
    this.message = 'Check your Wi-Fi or mobile data, then try again.',
    this.retryLabel = 'Try again',
    this.onRetry,
    this.openSettingsLabel,
    this.onOpenSettings,
    this.wrapWithScaffold = true,
  });

  /// The headline text.
  final String title;

  /// The supporting message.
  final String message;

  /// The label for the retry button.
  final String retryLabel;

  /// Called when the retry button is pressed.
  final VoidCallback? onRetry;

  /// The label for the optional open-settings button.
  final String? openSettingsLabel;

  /// Called when the open-settings button is pressed.
  final VoidCallback? onOpenSettings;

  /// Whether to wrap the content in a [Scaffold].
  final bool wrapWithScaffold;

  @override
  Widget build(BuildContext context) {
    return AppIssueScreen(
      title: title,
      message: message,
      icon: Icons.wifi_off_rounded,
      primaryActionLabel: retryLabel,
      onPrimaryAction: onRetry,
      secondaryActionLabel: openSettingsLabel,
      onSecondaryAction: onOpenSettings,
      semanticLabel: 'No internet connection',
      wrapWithScaffold: wrapWithScaffold,
    );
  }
}
