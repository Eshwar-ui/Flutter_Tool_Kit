import 'package:flutter/material.dart';

import 'ux_tokens.dart';

final class FocusRing extends StatefulWidget {
  const FocusRing({
    super.key,
    required this.child,
    this.borderRadius = AppRadius.small,
    this.padding = EdgeInsets.zero,
    this.color,
    this.focusNode,
  });

  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final FocusNode? focusNode;

  @override
  State<FocusRing> createState() => _FocusRingState();
}

final class _FocusRingState extends State<FocusRing> {
  bool _hasFocus = false;

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _hasFocus = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color ?? Theme.of(context).colorScheme.primary;

    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: _handleFocusChange,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: widget.padding,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: _hasFocus ? Border.all(color: color, width: 2) : null,
        ),
        child: widget.child,
      ),
    );
  }
}
