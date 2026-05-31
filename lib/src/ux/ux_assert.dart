import 'package:flutter/widgets.dart';

import 'ux_tokens.dart';

abstract final class UxAssert {
  static void hasSemanticLabel(String? label) {
    assert(
      label != null && label.trim().isNotEmpty,
      'Interactive icon-only controls must provide a semantic label.',
    );
  }

  static void hasMinTouchTarget(Size size) {
    assert(
      size.width >= AppTouchTargets.min && size.height >= AppTouchTargets.min,
      'Touch targets must be at least ${AppTouchTargets.min}x'
      '${AppTouchTargets.min}.',
    );
  }

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
