import 'package:flutter/widgets.dart';

import 'ux_tokens.dart';

final class AppTapFeedback extends StatefulWidget {
  const AppTapFeedback({
    super.key,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.scale = 0.97,
    this.pressedOpacity = 0.72,
    this.duration = AppDurations.instantFeedback,
    this.behavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final double scale;
  final double pressedOpacity;
  final Duration duration;
  final HitTestBehavior behavior;

  @override
  State<AppTapFeedback> createState() => _AppTapFeedbackState();
}

final class _AppTapFeedbackState extends State<AppTapFeedback> {
  bool _isPressed = false;

  bool get _canTap => widget.enabled && widget.onTap != null;

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
      behavior: widget.behavior,
      onTap: _canTap ? widget.onTap : null,
      onTapDown: _canTap ? (_) => _setPressed(true) : null,
      onTapCancel: _canTap ? () => _setPressed(false) : null,
      onTapUp: _canTap ? (_) => _setPressed(false) : null,
      child: AnimatedOpacity(
        opacity: _isPressed ? widget.pressedOpacity : 1,
        duration: widget.duration,
        child: AnimatedScale(
          scale: _isPressed ? widget.scale : 1,
          duration: widget.duration,
          child: widget.child,
        ),
      ),
    );
  }
}
