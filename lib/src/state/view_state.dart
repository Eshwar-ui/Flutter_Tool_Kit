/// An immutable representation of an asynchronous view's state: idle, loading,
/// loaded with data, empty, or failed.
///
/// Construct instances with the named factories (e.g. [ViewState.loading]) and
/// render them exhaustively with [when] or [maybeWhen]. Pair it with
/// `StateView` to map each state to a widget.
sealed class ViewState<T> {
  /// Creates a base view state. Use the named factories instead.
  const ViewState();

  /// The initial state before any work has started.
  const factory ViewState.idle() = IdleViewState<T>;

  /// The in-progress state, optionally carrying the [previousData] to keep
  /// showing while loading.
  const factory ViewState.loading({T? previousData}) = LoadingViewState<T>;

  /// The success state holding the loaded [value].
  const factory ViewState.data(T value) = DataViewState<T>;

  /// The successful-but-empty state, with an optional [message].
  const factory ViewState.empty({String? message}) = EmptyViewState<T>;

  /// The failure state holding the [error], an optional [stackTrace], and any
  /// [previousData] to keep showing.
  const factory ViewState.failure(
    Object error, {
    StackTrace? stackTrace,
    T? previousData,
  }) = FailureViewState<T>;

  /// Whether this is the idle state.
  bool get isIdle => this is IdleViewState<T>;

  /// Whether this is the loading state.
  bool get isLoading => this is LoadingViewState<T>;

  /// Whether this is the data state.
  bool get hasData => this is DataViewState<T>;

  /// Whether this is the empty state.
  bool get isEmpty => this is EmptyViewState<T>;

  /// Whether this is the failure state.
  bool get hasFailure => this is FailureViewState<T>;

  /// The current data if available, including any previous data preserved
  /// during loading or failure, otherwise `null`.
  T? get dataOrNull {
    return switch (this) {
      DataViewState<T>(:final value) => value,
      LoadingViewState<T>(:final previousData) => previousData,
      FailureViewState<T>(:final previousData) => previousData,
      _ => null,
    };
  }

  /// The error if this is a failure state, otherwise `null`.
  Object? get errorOrNull {
    return switch (this) {
      FailureViewState<T>(:final error) => error,
      _ => null,
    };
  }

  /// Maps every possible state to a value of type [R]. All branches are
  /// required, guaranteeing exhaustive handling.
  R when<R>({
    required R Function() idle,
    required R Function(T? previousData) loading,
    required R Function(T value) data,
    required R Function(String? message) empty,
    required R Function(Object error, StackTrace? stackTrace, T? previousData)
        failure,
  }) {
    return switch (this) {
      IdleViewState<T>() => idle(),
      LoadingViewState<T>(:final previousData) => loading(previousData),
      DataViewState<T>(:final value) => data(value),
      EmptyViewState<T>(:final message) => empty(message),
      FailureViewState<T>(
        :final error,
        :final stackTrace,
        :final previousData,
      ) =>
        failure(error, stackTrace, previousData),
    };
  }

  /// Maps the states you care about to a value of type [R], falling back to
  /// [orElse] for any branch left unhandled.
  R maybeWhen<R>({
    R Function()? idle,
    R Function(T? previousData)? loading,
    R Function(T value)? data,
    R Function(String? message)? empty,
    R Function(Object error, StackTrace? stackTrace, T? previousData)? failure,
    required R Function() orElse,
  }) {
    return switch (this) {
      IdleViewState<T>() => idle?.call() ?? orElse(),
      LoadingViewState<T>(:final previousData) =>
        loading?.call(previousData) ?? orElse(),
      DataViewState<T>(:final value) => data?.call(value) ?? orElse(),
      EmptyViewState<T>(:final message) => empty?.call(message) ?? orElse(),
      FailureViewState<T>(
        :final error,
        :final stackTrace,
        :final previousData,
      ) =>
        failure?.call(error, stackTrace, previousData) ?? orElse(),
    };
  }
}

/// The initial [ViewState] before any work has started.
final class IdleViewState<T> extends ViewState<T> {
  /// Creates an idle state.
  const IdleViewState();
}

/// The in-progress [ViewState], optionally preserving [previousData].
final class LoadingViewState<T> extends ViewState<T> {
  /// Creates a loading state, optionally keeping the [previousData].
  const LoadingViewState({this.previousData});

  /// Data from a prior successful load, kept visible while loading.
  final T? previousData;
}

/// The success [ViewState] holding the loaded [value].
final class DataViewState<T> extends ViewState<T> {
  /// Creates a data state holding [value].
  const DataViewState(this.value);

  /// The loaded data.
  final T value;
}

/// The successful-but-empty [ViewState], with an optional [message].
final class EmptyViewState<T> extends ViewState<T> {
  /// Creates an empty state with an optional [message].
  const EmptyViewState({this.message});

  /// An optional message describing why the result is empty.
  final String? message;
}

/// The failure [ViewState] holding the [error] and optional context.
final class FailureViewState<T> extends ViewState<T> {
  /// Creates a failure state for [error], with optional [stackTrace] and
  /// [previousData].
  const FailureViewState(this.error, {this.stackTrace, this.previousData});

  /// The error that caused the failure.
  final Object error;

  /// The stack trace associated with [error], if available.
  final StackTrace? stackTrace;

  /// Data from a prior successful load, kept visible after the failure.
  final T? previousData;
}
