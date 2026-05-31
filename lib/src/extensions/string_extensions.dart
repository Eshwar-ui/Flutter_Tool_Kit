/// Convenience helpers for working with [String] values.
extension StringExtensions on String {
  /// Whether the string is empty or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Whether the string contains at least one non-whitespace character.
  bool get isNotBlank => !isBlank;

  /// The string trimmed and with consecutive whitespace collapsed to a
  /// single space.
  String get normalizedSpaces => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// The string with its first character upper-cased after normalizing
  /// whitespace.
  String get capitalized {
    final String value = normalizedSpaces;
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  /// The string with the first letter of every word upper-cased.
  String get titleCased {
    return normalizedSpaces
        .split(' ')
        .map((String word) => word.isEmpty ? word : word.capitalized)
        .join(' ');
  }
}

/// Convenience helpers for working with nullable [String] values.
extension NullableStringExtensions on String? {
  /// Whether the string is `null`, empty, or contains only whitespace.
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// Returns the string, or `null` when it is `null`, empty, or blank.
  String? get nullIfBlank {
    final String? value = this;
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value;
  }
}
