import 'package:flutter/widgets.dart';

enum ResponsiveSize { mobile, tablet, desktop }

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  ResponsiveSize size,
  BoxConstraints constraints,
);

final class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.tabletBreakpoint = 600,
    this.desktopBreakpoint = 1024,
  });

  final ResponsiveWidgetBuilder builder;
  final double tabletBreakpoint;
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
