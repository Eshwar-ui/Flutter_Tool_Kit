extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String get normalizedSpaces => trim().replaceAll(RegExp(r'\s+'), ' ');

  String get capitalized {
    final String value = normalizedSpaces;
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  String get titleCased {
    return normalizedSpaces
        .split(' ')
        .map((String word) => word.isEmpty ? word : word.capitalized)
        .join(' ');
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  String? get nullIfBlank {
    final String? value = this;
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value;
  }
}
