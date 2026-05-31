import 'package:flutter/material.dart';

/// A confirmation [AlertDialog] with confirm and cancel actions, optionally
/// styled for destructive operations.
///
/// Use [ConfirmActionDialog.show] to display it and await a `bool` result.
final class ConfirmActionDialog extends StatelessWidget {
  /// Creates a confirmation dialog.
  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  /// The dialog headline.
  final String title;

  /// The dialog body message.
  final String message;

  /// The label for the confirm button.
  final String confirmLabel;

  /// The label for the cancel button.
  final String cancelLabel;

  /// Whether to style the confirm button as a destructive action.
  final bool isDestructive;

  /// Shows the dialog and resolves to `true` if confirmed, `false` otherwise
  /// (including when dismissed).
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmActionDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          isDestructive: isDestructive,
        );
      },
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
                )
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
