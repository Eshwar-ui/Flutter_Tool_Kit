import 'package:flutter/widgets.dart';

/// The responsive size bucket resolved from the available width.
enum ResponsiveSize {
  /// A narrow, phone-sized layout.
  mobile,

  /// A medium, tablet-sized layout.
  tablet,

  /// A wide, desktop-sized layout.
  desktop,
}

/// Builds a widget from the current [BuildContext], resolved [ResponsiveSize],
/// and layout [BoxConstraints].
typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  ResponsiveSize size,
  BoxConstraints constraints,
);

/// Rebuilds its [builder] with the [ResponsiveSize] derived from the available
/// width, so layouts can adapt to mobile, tablet, and desktop breakpoints.
final class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder.
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.tabletBreakpoint = 600,
    this.desktopBreakpoint = 1024,
  });

  /// Builds the widget for the resolved size and constraints.
  final ResponsiveWidgetBuilder builder;

  /// The width (inclusive) at which the layout becomes [ResponsiveSize.tablet].
  final double tabletBreakpoint;

  /// The width (inclusive) at which the layout becomes
  /// [ResponsiveSize.desktop].
  final double desktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final ResponsiveSize size;
        if (width >= desktopBreakpoint) {
          size = ResponsiveSize.desktop;
        } else if (width >= tabletBreakpoint) {
          size = ResponsiveSize.tablet;
        } else {
          size = ResponsiveSize.mobile;
        }

        return builder(context, size, constraints);
      },
    );
  }
}
