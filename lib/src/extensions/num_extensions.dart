import 'package:flutter/widgets.dart';

/// Builds [Duration] values from numeric literals, e.g. `300.milliseconds`.
extension NumDurationExtensions on num {
  /// A [Duration] of this many milliseconds.
  Duration get milliseconds => Duration(milliseconds: round());

  /// A [Duration] of this many seconds.
  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  /// A [Duration] of this many minutes.
  Duration get minutes => Duration(milliseconds: (this * 60000).round());
}

/// Builds spacing widgets and [EdgeInsets] from numeric literals,
/// e.g. `16.gapY` or `8.paddingAll`.
extension NumSpacingExtensions on num {
  /// A horizontal [SizedBox] of this width.
  SizedBox get gapX => SizedBox(width: toDouble());

  /// A vertical [SizedBox] of this height.
  SizedBox get gapY => SizedBox(height: toDouble());

  /// [EdgeInsets] with this value applied to all sides.
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// [EdgeInsets] with this value applied to the left and right.
  EdgeInsets get paddingHorizontal {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  /// [EdgeInsets] with this value applied to the top and bottom.
  EdgeInsets get paddingVertical {
    return EdgeInsets.symmetric(vertical: toDouble());
  }
}
