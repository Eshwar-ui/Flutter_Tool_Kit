import 'package:flutter/widgets.dart';

/// An [InheritedWidget] that exposes a form's submission state to descendants,
/// letting buttons and fields react to whether the form is submitting or can
/// be submitted.
final class FormSubmitScope extends InheritedWidget {
  /// Creates a form-submit scope.
  const FormSubmitScope({
    super.key,
    required this.isSubmitting,
    required this.canSubmit,
    required super.child,
  });

  /// Whether the form is currently submitting.
  final bool isSubmitting;

  /// Whether the form is currently in a submittable state.
  final bool canSubmit;

  /// Returns the nearest [FormSubmitScope], or `null` if none is found.
  static FormSubmitScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormSubmitScope>();
  }

  /// Returns the nearest [FormSubmitScope]. Asserts that one exists.
  static FormSubmitScope of(BuildContext context) {
    final FormSubmitScope? scope = maybeOf(context);
    assert(scope != null, 'No FormSubmitScope found in context.');
    return scope!;
  }

  @override
  bool updateShouldNotify(FormSubmitScope oldWidget) {
    return isSubmitting != oldWidget.isSubmitting ||
        canSubmit != oldWidget.canSubmit;
  }
}
