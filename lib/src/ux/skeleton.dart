import 'package:flutter/material.dart';

import 'ux_tokens.dart';

/// A pulsing placeholder box used to indicate loading content (shimmer-style
/// skeleton).
final class SkeletonBox extends StatelessWidget {
  /// Creates a skeleton placeholder box.
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = AppRadius.small,
    this.baseColor,
    this.highlightColor,
  });

  /// The box width; `null` fills the available width.
  final double? width;

  /// The box height.
  final double height;

  /// The corner radius of the box.
  final BorderRadiusGeometry borderRadius;

  /// The base (dimmer) color; defaults to a theme surface color.
  final Color? baseColor;

  /// The highlight (brighter) color; defaults to a theme surface color.
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color beginColor = baseColor ??
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

/// A scrollable list of [SkeletonBox] rows used as a loading placeholder for
/// list content.
final class SkeletonList extends StatelessWidget {
  /// Creates a skeleton list placeholder.
  const SkeletonList({
    super.key,
    this.itemCount = 6,
    this.spacing = AppSpacing.md,
    this.itemHeight = 72,
    this.padding = AppSpacing.screenPadding,
  });

  /// The number of placeholder rows to show.
  final int itemCount;

  /// The vertical spacing between rows.
  final double spacing;

  /// The height of each placeholder row.
  final double itemHeight;

  /// Padding around the list.
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
