import 'package:flutter/material.dart';

import '../ux/ux_tokens.dart';

final class AppIssueScreen extends StatelessWidget {
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

  final String title;
  final String message;
  final IconData icon;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final String? semanticLabel;
  final bool wrapWithScaffold;
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
