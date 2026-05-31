import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets sectionPadding = EdgeInsets.all(lg);
}

abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;

  static const BorderRadius small = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(md));
  static const BorderRadius large = BorderRadius.all(Radius.circular(lg));
}

abstract final class AppDurations {
  static const Duration instantFeedback = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 300);
}

abstract final class AppBreakpoints {
  static const double mobile = 0;
  static const double tablet = 600;
  static const double desktop = 1024;
}

abstract final class AppTouchTargets {
  static const double min = 44;
  static const Size minSize = Size(min, min);
}
