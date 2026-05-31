import 'package:flutter/material.dart';

import 'ux_tokens.dart';

/// Draws an animated focus outline around [child] when it gains keyboard
/// focus, improving keyboard and accessibility navigation.
final class FocusRing extends StatefulWidget {
  /// Creates a focus ring around [child].
  const FocusRing({
    super.key,
    required this.child,
    this.borderRadius = AppRadius.small,
    this.padding = EdgeInsets.zero,
    this.color,
    this.focusNode,
  });

  /// The widget that receives focus and is outlined.
  final Widget child;

  /// The corner radius of the focus outline.
  final BorderRadiusGeometry borderRadius;

  /// Padding between [child] and the outline.
  final EdgeInsetsGeometry padding;

  /// The outline color; defaults to the theme's primary color.
  final Color? color;

  /// An optional focus node to observe instead of an internal one.
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
