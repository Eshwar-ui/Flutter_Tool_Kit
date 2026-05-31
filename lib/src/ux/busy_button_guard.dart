import 'package:flutter/widgets.dart';

/// Builds a button given the current busy state and a tap handler.
///
/// [onPressed] is `null` while busy or disabled, so the button can render an
/// inactive/spinner state.
typedef BusyButtonBuilder = Widget Function(
  BuildContext context,
  bool isBusy,
  VoidCallback? onPressed,
);

/// Guards an async action so it cannot run concurrently: it tracks the
/// in-flight state and disables the button until the [Future] completes.
final class BusyButtonGuard extends StatefulWidget {
  /// Creates a busy-button guard.
  const BusyButtonGuard({
    super.key,
    required this.onPressed,
    required this.builder,
    this.enabled = true,
  });

  /// The async action to run; the guard prevents overlapping invocations.
  final Future<void> Function()? onPressed;

  /// Builds the button from the current busy state and tap handler.
  final BusyButtonBuilder builder;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  State<BusyButtonGuard> createState() => _BusyButtonGuardState();
}

final class _BusyButtonGuardState extends State<BusyButtonGuard> {
  bool _isBusy = false;

  bool get _canSubmit => widget.enabled && !_isBusy && widget.onPressed != null;

  Future<void> _handlePressed() async {
    if (!_canSubmit) {
      return;
    }

    setState(() {
      _isBusy = true;
    });

    try {
      await widget.onPressed?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _isBusy,
      _canSubmit ? _handlePressed : null,
    );
  }
}
