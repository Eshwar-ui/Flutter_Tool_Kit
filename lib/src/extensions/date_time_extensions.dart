/// Convenience helpers for comparing and truncating [DateTime] values.
extension DateTimeExtensions on DateTime {
  /// This date at midnight (00:00:00.000).
  DateTime get startOfDay => DateTime(year, month, day);

  /// This date at the last representable moment (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Whether this date falls on the same calendar day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Whether this date falls on today's calendar day.
  bool get isToday => isSameDay(DateTime.now());

  /// Whether this date falls on yesterday's calendar day.
  bool get isYesterday {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  /// Whether this date falls on tomorrow's calendar day.
  bool get isTomorrow {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }
}
