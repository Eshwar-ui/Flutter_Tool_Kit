sealed class ViewState<T> {
  const ViewState();

  const factory ViewState.idle() = IdleViewState<T>;

  const factory ViewState.loading({T? previousData}) = LoadingViewState<T>;

  const factory ViewState.data(T value) = DataViewState<T>;

  const factory ViewState.empty({String? message}) = EmptyViewState<T>;

  const factory ViewState.failure(
    Object error, {
    StackTrace? stackTrace,
    T? previousData,
  }) = FailureViewState<T>;

  bool get isIdle => this is IdleViewState<T>;

  bool get isLoading => this is LoadingViewState<T>;

  bool get hasData => this is DataViewState<T>;

  bool get isEmpty => this is EmptyViewState<T>;

  bool get hasFailure => this is FailureViewState<T>;

  T? get dataOrNull {
    return switch (this) {
      DataViewState<T>(:final value) => value,
      LoadingViewState<T>(:final previousData) => previousData,
      FailureViewState<T>(:final previousData) => previousData,
      _ => null,
    };
  }

  Object? get errorOrNull {
    return switch (this) {
      FailureViewState<T>(:final error) => error,
      _ => null,
    };
  }

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

final class IdleViewState<T> extends ViewState<T> {
  const IdleViewState();
}

final class LoadingViewState<T> extends ViewState<T> {
  const LoadingViewState({this.previousData});

  final T? previousData;
}

final class DataViewState<T> extends ViewState<T> {
  const DataViewState(this.value);

  final T value;
}

final class EmptyViewState<T> extends ViewState<T> {
  const EmptyViewState({this.message});

  final String? message;
}

final class FailureViewState<T> extends ViewState<T> {
  const FailureViewState(this.error, {this.stackTrace, this.previousData});

  final Object error;
  final StackTrace? stackTrace;
  final T? previousData;
}
