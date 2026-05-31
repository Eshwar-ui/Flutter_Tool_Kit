import 'package:flutter/material.dart';

import 'ux_tokens.dart';

final class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = AppRadius.small,
    this.baseColor,
    this.highlightColor,
  });

  final double? width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color beginColor =
        baseColor ??
        colorScheme.surfaceContainerHighest.withValues(alpha: 0.72);
    final Color endColor =
        highlightColor ?? colorScheme.surfaceContainerHighest;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      builder: (BuildContext context, double value, Widget? child) {
        final double opacity = 0.55 + (value * 0.35);

        return Opacity(opacity: opacity, child: child);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Color.lerp(beginColor, endColor, 0.5),
        ),
        child: SizedBox(width: width, height: height),
      ),
    );
  }
}

final class SkeletonList extends StatelessWidget {
  const SkeletonList({
    super.key,
    this.itemCount = 6,
    this.spacing = AppSpacing.md,
    this.itemHeight = 72,
    this.padding = AppSpacing.screenPadding,
  });

  final int itemCount;
  final double spacing;
  final double itemHeight;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: spacing);
      },
      itemBuilder: (BuildContext context, int index) {
        return SkeletonBox(height: itemHeight, borderRadius: AppRadius.medium);
      },
    );
  }
}
