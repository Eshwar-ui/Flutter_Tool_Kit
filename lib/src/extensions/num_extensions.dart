import 'package:flutter/widgets.dart';

extension NumDurationExtensions on num {
  Duration get milliseconds => Duration(milliseconds: round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes => Duration(milliseconds: (this * 60000).round());
}

extension NumSpacingExtensions on num {
  SizedBox get gapX => SizedBox(width: toDouble());

  SizedBox get gapY => SizedBox(height: toDouble());

  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  EdgeInsets get paddingHorizontal {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  EdgeInsets get paddingVertical {
    return EdgeInsets.symmetric(vertical: toDouble());
  }
}
