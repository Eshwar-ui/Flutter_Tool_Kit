import 'package:flutter/widgets.dart';

/// Scales its [child] down briefly while pressed to give lightweight tactile
/// feedback to taps.
final class TapScale extends StatefulWidget {
  /// Creates a tap-scale wrapper.
  const TapScale({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.96,
    this.duration = const Duration(milliseconds: 90),
  });

  /// The widget to apply the scale effect to.
  final Widget child;

  /// Called when the child is tapped.
  final VoidCallback? onTap;

  /// The scale applied while pressed (1.0 = no scaling).
  final double scale;

  /// The duration of the scale animation.
  final Duration duration;

  @override
  State<TapScale> createState() => _TapScaleState();
}

final class _TapScaleState extends State<TapScale> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) {
      return;
    }
    setState(() {
      _isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: widget.onTap == null ? null : (_) => _setPressed(true),
      onTapCancel: widget.onTap == null ? null : () => _setPressed(false),
      onTapUp: widget.onTap == null ? null : (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
