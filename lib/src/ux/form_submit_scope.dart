import 'package:flutter/widgets.dart';

final class FormSubmitScope extends InheritedWidget {
  const FormSubmitScope({
    super.key,
    required this.isSubmitting,
    required this.canSubmit,
    required super.child,
  });

  final bool isSubmitting;
  final bool canSubmit;

  static FormSubmitScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormSubmitScope>();
  }

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
