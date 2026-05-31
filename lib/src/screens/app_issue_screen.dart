import 'package:flutter/material.dart';

import '../ux/ux_tokens.dart';

/// A centered, scrollable screen for communicating an issue or empty/error
/// state, with an icon, title, message, and up to two action buttons.
///
/// Used as the building block for [NoInternetScreen], [NoServerConnectionScreen],
/// and [PermissionScreen], but can be used directly for any full-page state.
final class AppIssueScreen extends StatelessWidget {
  /// Creates an issue screen.
  const AppIssueScreen({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.semanticLabel,
    this.wrapWithScaffold = true,
    this.padding = AppSpacing.sectionPadding,
  });

  /// The headline describing the issue.
  final String title;

  /// The supporting message explaining the issue.
  final String message;

  /// The icon displayed above the title.
  final IconData icon;

  /// The label for the primary button; the button is hidden when `null`.
  final String? primaryActionLabel;

  /// Called when the primary button is pressed.
  final VoidCallback? onPrimaryAction;

  /// The label for the secondary button; the button is hidden when `null`.
  final String? secondaryActionLabel;

  /// Called when the secondary button is pressed.
  final VoidCallback? onSecondaryAction;

  /// An accessibility label for the screen; defaults to [title].
  final String? semanticLabel;

  /// Whether to wrap the content in a [Scaffold]. Disable when embedding.
  final bool wrapWithScaffold;

  /// Padding around the content.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final Widget body = SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: padding,
          child: Semantics(
            label: semanticLabel ?? title,
            explicitChildNodes: true,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _IssueIcon(icon: icon),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  if (primaryActionLabel != null &&
                      onPrimaryAction != null) ...<Widget>[
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: onPrimaryAction,
                        child: Text(primaryActionLabel!),
                      ),
                    ),
                  ],
                  if (secondaryActionLabel != null &&
                      onSecondaryAction != null) ...<Widget>[
                    const SizedBox(height: AppSpacing.xs),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: onSecondaryAction,
                        child: Text(secondaryActionLabel!),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (!wrapWithScaffold) {
      return body;
    }

    return Scaffold(body: body);
  }
}

final class _IssueIcon extends StatelessWidget {
  const _IssueIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.large,
      ),
      child: SizedBox.square(
        dimension: 80,
        child: Icon(icon, size: 40, color: colorScheme.primary),
      ),
    );
  }
}
