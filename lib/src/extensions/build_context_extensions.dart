import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isMobile => screenWidth < 600;

  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  bool get isDesktop => screenWidth >= 1024;

  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), action: action, duration: duration),
    );
  }
}
