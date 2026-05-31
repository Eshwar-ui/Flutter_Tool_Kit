import 'package:flutter/widgets.dart';

/// A fixed-size empty space used to separate widgets along a single axis.
///
/// Provides named constructors for the standard spacing scale (e.g.
/// `AppGap.md()`), defaulting to a vertical gap.
final class AppGap extends StatelessWidget {
  /// Creates a gap of [size] logical pixels along [axis].
  const AppGap(this.size, {super.key, this.axis = Axis.vertical});

  /// Creates a 4-pixel gap.
  const AppGap.xxs({super.key, this.axis = Axis.vertical}) : size = 4;

  /// Creates an 8-pixel gap.
  const AppGap.xs({super.key, this.axis = Axis.vertical}) : size = 8;

  /// Creates a 12-pixel gap.
  const AppGap.sm({super.key, this.axis = Axis.vertical}) : size = 12;

  /// Creates a 16-pixel gap.
  const AppGap.md({super.key, this.axis = Axis.vertical}) : size = 16;

  /// Creates a 24-pixel gap.
  const AppGap.lg({super.key, this.axis = Axis.vertical}) : size = 24;

  /// Creates a 32-pixel gap.
  const AppGap.xl({super.key, this.axis = Axis.vertical}) : size = 32;

  /// The gap extent in logical pixels.
  final double size;

  /// The axis the gap spans (vertical or horizontal).
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : 0,
      height: axis == Axis.vertical ? size : 0,
    );
  }
}
