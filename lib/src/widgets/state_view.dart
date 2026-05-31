import 'package:flutter/material.dart';

import '../state/view_state.dart';
import 'empty_state.dart';
import 'loading_state.dart';

typedef StateDataBuilder<T> = Widget Function(BuildContext context, T value);

typedef StateErrorBuilder<T> = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
  T? previousData,
);

final class StateView<T> extends StatelessWidget {
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

  final ViewState<T> state;
  final StateDataBuilder<T> dataBuilder;
  final WidgetBuilder? idleBuilder;
  final Widget Function(BuildContext context, T? previousData)? loadingBuilder;
  final Widget Function(BuildContext context, String? message)? emptyBuilder;
  final StateErrorBuilder<T>? errorBuilder;
  final VoidCallback? onRetry;
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
