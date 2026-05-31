import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tool_kit/flutter_tool_kit.dart';

void main() {
  test('ViewState exposes data and errors consistently', () {
    const ViewState<int> loading = ViewState.loading(previousData: 2);
    const ViewState<int> data = ViewState.data(4);
    const ViewState<int> failure = ViewState.failure('failed');

    expect(loading.isLoading, isTrue);
    expect(loading.dataOrNull, 2);
    expect(data.hasData, isTrue);
    expect(data.dataOrNull, 4);
    expect(failure.hasFailure, isTrue);
    expect(failure.errorOrNull, 'failed');
  });

  test('ViewState.when dispatches by subtype', () {
    const ViewState<String> state = ViewState.empty(message: 'No items');

    final String result = state.when(
      idle: () => 'idle',
      loading: (String? previousData) => 'loading',
      data: (String value) => value,
      empty: (String? message) => message ?? 'empty',
      failure: (Object error, StackTrace? stackTrace, String? previousData) =>
          error.toString(),
    );

    expect(result, 'No items');
  });
}
