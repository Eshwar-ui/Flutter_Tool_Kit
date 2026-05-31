extension IterableExtensions<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;

  T? firstWhereOrNull(bool Function(T item) test) {
    for (final T item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }

  Iterable<R> mapIndexed<R>(R Function(int index, T item) convert) sync* {
    int index = 0;
    for (final T item in this) {
      yield convert(index, item);
      index += 1;
    }
  }

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
