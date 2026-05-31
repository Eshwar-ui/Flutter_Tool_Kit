import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

final class NoInternetScreen extends StatelessWidget {
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

  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final String? openSettingsLabel;
  final VoidCallback? onOpenSettings;
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
