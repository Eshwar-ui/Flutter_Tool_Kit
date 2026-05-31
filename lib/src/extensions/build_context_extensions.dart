import 'package:flutter/material.dart';

/// Shortcuts for common [BuildContext] lookups such as theme, media query,
/// screen size, and snack bars.
extension BuildContextExtensions on BuildContext {
  /// The nearest [ThemeData] for this context.
  ThemeData get theme => Theme.of(this);

  /// The current [ColorScheme] from the active theme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// The current [TextTheme] from the active theme.
  TextTheme get textTheme => theme.textTheme;

  /// The nearest [MediaQueryData] for this context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// The size of the media (typically the screen) in logical pixels.
  Size get screenSize => mediaQuery.size;

  /// The width of the screen in logical pixels.
  double get screenWidth => screenSize.width;

  /// The height of the screen in logical pixels.
  double get screenHeight => screenSize.height;

  /// Whether the screen width is below the tablet breakpoint (600).
  bool get isMobile => screenWidth < 600;

  /// Whether the screen width falls within the tablet range (600–1023).
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// Whether the screen width is at or above the desktop breakpoint (1024).
  bool get isDesktop => screenWidth >= 1024;

  /// The padding insets imposed by system UI such as notches and status bars.
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Dismisses the on-screen keyboard by removing focus.
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Shows a [SnackBar] with [message] using the nearest [ScaffoldMessenger].
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
