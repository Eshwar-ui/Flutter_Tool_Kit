import 'package:flutter/widgets.dart';

import 'ux_tokens.dart';

/// Debug-only assertions that enforce common UX and accessibility invariants.
///
/// These run only in debug builds (via `assert`) and have no effect in
/// release.
abstract final class UxAssert {
  /// Asserts that [label] is a non-empty semantic label.
  static void hasSemanticLabel(String? label) {
    assert(
      label != null && label.trim().isNotEmpty,
      'Interactive icon-only controls must provide a semantic label.',
    );
  }

  /// Asserts that [size] meets the minimum touch-target dimensions.
  static void hasMinTouchTarget(Size size) {
    assert(
      size.width >= AppTouchTargets.min && size.height >= AppTouchTargets.min,
      'Touch targets must be at least ${AppTouchTargets.min}x'
      '${AppTouchTargets.min}.',
    );
  }

  /// Asserts that an enabled control provides a non-null [action].
  static void enabledControlHasAction({
    required bool enabled,
    required VoidCallback? action,
  }) {
    assert(
      !enabled || action != null,
      'Enabled interactive controls must provide an action.',
    );
  }
}
