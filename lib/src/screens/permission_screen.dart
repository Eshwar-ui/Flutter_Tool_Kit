import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

/// A ready-made screen that prompts the user to grant a named permission,
/// offering allow and open-settings actions.
final class PermissionScreen extends StatelessWidget {
  /// Creates a permission-request screen for [permissionName].
  const PermissionScreen({
    super.key,
    required this.permissionName,
    this.title,
    this.message,
    this.icon = Icons.lock_outline_rounded,
    this.primaryActionLabel = 'Allow permission',
    this.onPrimaryAction,
    this.settingsLabel = 'Open settings',
    this.onOpenSettings,
    this.wrapWithScaffold = true,
  });

  /// The human-readable name of the permission being requested.
  final String permissionName;

  /// An optional custom headline; defaults to a message using [permissionName].
  final String? title;

  /// An optional custom message; defaults to a prompt using [permissionName].
  final String? message;

  /// The icon displayed above the title.
  final IconData icon;

  /// The label for the primary allow button.
  final String primaryActionLabel;

  /// Called when the allow button is pressed.
  final VoidCallback? onPrimaryAction;

  /// The label for the optional open-settings button.
  final String? settingsLabel;

  /// Called when the open-settings button is pressed.
  final VoidCallback? onOpenSettings;

  /// Whether to wrap the content in a [Scaffold].
  final bool wrapWithScaffold;

  @override
  Widget build(BuildContext context) {
    return AppIssueScreen(
      title: title ?? '$permissionName permission needed',
      message: message ??
          'Enable $permissionName permission to continue using this feature.',
      icon: icon,
      primaryActionLabel: primaryActionLabel,
      onPrimaryAction: onPrimaryAction,
      secondaryActionLabel: settingsLabel,
      onSecondaryAction: onOpenSettings,
      semanticLabel: '$permissionName permission needed',
      wrapWithScaffold: wrapWithScaffold,
    );
  }
}
