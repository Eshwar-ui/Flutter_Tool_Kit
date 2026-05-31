import 'package:flutter/widgets.dart';

final class AppGap extends StatelessWidget {
  const AppGap(this.size, {super.key, this.axis = Axis.vertical});

  const AppGap.xxs({super.key, this.axis = Axis.vertical}) : size = 4;

  const AppGap.xs({super.key, this.axis = Axis.vertical}) : size = 8;

  const AppGap.sm({super.key, this.axis = Axis.vertical}) : size = 12;

  const AppGap.md({super.key, this.axis = Axis.vertical}) : size = 16;

  const AppGap.lg({super.key, this.axis = Axis.vertical}) : size = 24;

  const AppGap.xl({super.key, this.axis = Axis.vertical}) : size = 32;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : 0,
      height: axis == Axis.vertical ? size : 0,
    );
  }
}
