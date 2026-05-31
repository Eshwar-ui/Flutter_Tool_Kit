import 'package:flutter/material.dart';

/// Standard spacing values and common padding presets used across the package
/// for consistent layout rhythm.
abstract final class AppSpacing {
  /// 4 logical pixels.
  static const double xxs = 4;

  /// 8 logical pixels.
  static const double xs = 8;

  /// 12 logical pixels.
  static const double sm = 12;

  /// 16 logical pixels.
  static const double md = 16;

  /// 24 logical pixels.
  static const double lg = 24;

  /// 32 logical pixels.
  static const double xl = 32;

  /// Default padding for screen-level content ([md] on all sides).
  static const EdgeInsets screenPadding = EdgeInsets.all(md);

  /// Default padding for section-level content ([lg] on all sides).
  static const EdgeInsets sectionPadding = EdgeInsets.all(lg);
}

/// Standard corner-radius values and ready-made [BorderRadius] presets.
abstract final class AppRadius {
  /// 4 logical pixels.
  static const double xs = 4;

  /// 8 logical pixels.
  static const double sm = 8;

  /// 12 logical pixels.
  static const double md = 12;

  /// 16 logical pixels.
  static const double lg = 16;

  /// A large value (999) for fully rounded "pill" shapes.
  static const double pill = 999;

  /// A small [BorderRadius] built from [sm].
  static const BorderRadius small = BorderRadius.all(Radius.circular(sm));

  /// A medium [BorderRadius] built from [md].
  static const BorderRadius medium = BorderRadius.all(Radius.circular(md));

  /// A large [BorderRadius] built from [lg].
  static const BorderRadius large = BorderRadius.all(Radius.circular(lg));
}

/// Standard animation durations used for consistent motion timing.
abstract final class AppDurations {
  /// 100ms — near-instant press feedback.
  static const Duration instantFeedback = Duration(milliseconds: 100);

  /// 150ms — fast transitions.
  static const Duration fast = Duration(milliseconds: 150);

  /// 220ms — the default transition speed.
  static const Duration normal = Duration(milliseconds: 220);

  /// 300ms — slow, deliberate transitions.
  static const Duration slow = Duration(milliseconds: 300);
}

/// Responsive layout breakpoints (in logical pixels) for mobile, tablet, and
/// desktop widths.
abstract final class AppBreakpoints {
  /// The mobile breakpoint (0 and up).
  static const double mobile = 0;

  /// The tablet breakpoint (600 and up).
  static const double tablet = 600;

  /// The desktop breakpoint (1024 and up).
  static const double desktop = 1024;
}

/// Minimum touch-target sizing for accessible, tappable controls.
abstract final class AppTouchTargets {
  /// The minimum side length (44 logical pixels) for a touch target.
  static const double min = 44;

  /// The minimum touch-target [Size] ([min] × [min]).
  static const Size minSize = Size(min, min);
}
