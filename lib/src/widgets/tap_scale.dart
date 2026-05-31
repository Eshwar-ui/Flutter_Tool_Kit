import 'package:flutter/widgets.dart';

final class TapScale extends StatefulWidget {
  const TapScale({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.96,
    this.duration = const Duration(milliseconds: 90),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
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
