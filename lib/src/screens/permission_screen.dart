import 'package:flutter/material.dart';

import 'app_issue_screen.dart';

final class PermissionScreen extends StatelessWidget {
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

  final String permissionName;
  final String? title;
  final String? message;
  final IconData icon;
  final String primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? settingsLabel;
  final VoidCallback? onOpenSettings;
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
