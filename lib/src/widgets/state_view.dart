import 'package:flutter/material.dart';

import '../state/view_state.dart';
import 'empty_state.dart';
import 'loading_state.dart';

/// Builds the widget shown for a loaded [value].
typedef StateDataBuilder<T> = Widget Function(BuildContext context, T value);

/// Builds the widget shown for a failure, given the error, stack trace, and
/// any previously loaded data.
typedef StateErrorBuilder<T> = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
  T? previousData,
);

/// Renders a [ViewState] by mapping each state (idle, loading, data, empty,
/// failure) to a widget, falling back to sensible defaults
/// ([LoadingState]/[EmptyState]) when no custom builder is provided.
final class StateView<T> extends StatelessWidget {
  /// Creates a state view driven by [state].
  const StateView({
    super.key,
    required this.state,
    required this.dataBuilder,
    this.idleBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.onRetry,
    this.compact = false,
  });

  /// The current state to render.
  final ViewState<T> state;

  /// Builds the widget for loaded data. Required.
  final StateDataBuilder<T> dataBuilder;

  /// Builds the widget for the idle state; defaults to an empty box.
  final WidgetBuilder? idleBuilder;

  /// Builds the widget for the loading state; defaults to [LoadingState].
  final Widget Function(BuildContext context, T? previousData)? loadingBuilder;

  /// Builds the widget for the empty state; defaults to [EmptyState].
  final Widget Function(BuildContext context, String? message)? emptyBuilder;

  /// Builds the widget for the failure state; defaults to a retryable
  /// [EmptyState].
  final StateErrorBuilder<T>? errorBuilder;

  /// Called by the default failure view's retry button.
  final VoidCallback? onRetry;

  /// Whether default placeholders use their compact variants.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return state.when(
      idle: () => idleBuilder?.call(context) ?? const SizedBox.shrink(),
      loading: (T? previousData) {
        return loadingBuilder?.call(context, previousData) ??
            LoadingState(compact: compact);
      },
      data: (T value) => dataBuilder(context, value),
      empty: (String? message) {
        return emptyBuilder?.call(context, message) ??
            EmptyState(title: message ?? 'Nothing here yet', compact: compact);
      },
      failure: (Object error, StackTrace? stackTrace, T? previousData) {
        return errorBuilder?.call(context, error, stackTrace, previousData) ??
            EmptyState(
              title: 'Something went wrong',
              message: error.toString(),
              icon: Icons.error_outline,
              onRetry: onRetry,
              compact: compact,
            );
      },
    );
  }
}
