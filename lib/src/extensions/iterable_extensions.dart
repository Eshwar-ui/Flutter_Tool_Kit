/// Null-safe and indexing helpers for any [Iterable].
extension IterableExtensions<T> on Iterable<T> {
  /// The first element, or `null` when the iterable is empty.
  T? get firstOrNull => isEmpty ? null : first;

  /// The last element, or `null` when the iterable is empty.
  T? get lastOrNull => isEmpty ? null : last;

  /// The first element matching [test], or `null` when none match.
  T? firstWhereOrNull(bool Function(T item) test) {
    for (final T item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }

  /// Maps each element to a value while exposing its zero-based index.
  Iterable<R> mapIndexed<R>(R Function(int index, T item) convert) sync* {
    int index = 0;
    for (final T item in this) {
      yield convert(index, item);
      index += 1;
    }
  }

  /// Yields the elements with [separator] inserted between each pair.
  Iterable<T> separatedBy(T separator) sync* {
    bool isFirst = true;
    for (final T item in this) {
      if (!isFirst) {
        yield separator;
      }
      yield item;
      isFirst = false;
    }
  }
}
