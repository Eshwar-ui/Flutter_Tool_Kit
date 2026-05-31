import 'package:flutter/widgets.dart';

typedef BusyButtonBuilder = Widget Function(
  BuildContext context,
  bool isBusy,
  VoidCallback? onPressed,
);

final class BusyButtonGuard extends StatefulWidget {
  const BusyButtonGuard({
    super.key,
    required this.onPressed,
    required this.builder,
    this.enabled = true,
  });

  final Future<void> Function()? onPressed;
  final BusyButtonBuilder builder;
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
