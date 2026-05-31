import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

/// A ready-made screen shown when the app cannot reach its server, offering
/// retry and optional contact-support actions.
final class NoServerConnectionScreen extends StatelessWidget {
  /// Creates a no-server-connection screen.
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

  /// The headline text.
  final String title;

  /// The supporting message.
  final String message;

  /// The label for the retry button.
  final String retryLabel;

  /// Called when the retry button is pressed.
  final VoidCallback? onRetry;

  /// The label for the optional contact-support button.
  final String? contactSupportLabel;

  /// Called when the contact-support button is pressed.
  final VoidCallback? onContactSupport;

  /// Whether to wrap the content in a [Scaffold].
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
