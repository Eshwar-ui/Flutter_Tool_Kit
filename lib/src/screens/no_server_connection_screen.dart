import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

final class NoServerConnectionScreen extends StatelessWidget {
  const NoServerConnectionScreen({
    super.key,
    this.title = 'Server connection failed',
    this.message = 'We could not reach the server. Please try again shortly.',
    this.retryLabel = 'Retry',
    this.onRetry,
    this.contactSupportLabel,
    this.onContactSupport,
    this.wrapWithScaffold = true,
  });

  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final String? contactSupportLabel;
  final VoidCallback? onContactSupport;
  final bool wrapWithScaffold;

  @override
  Widget build(BuildContext context) {
    return AppIssueScreen(
      title: title,
      message: message,
      icon: Icons.cloud_off_rounded,
      primaryActionLabel: retryLabel,
      onPrimaryAction: onRetry,
      secondaryActionLabel: contactSupportLabel,
      onSecondaryAction: onContactSupport,
      semanticLabel: 'Server connection failed',
      wrapWithScaffold: wrapWithScaffold,
    );
  }
}
