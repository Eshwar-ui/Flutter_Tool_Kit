extension DateTimeExtensions on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday => isSameDay(DateTime.now());

  bool get isYesterday {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  bool get isTomorrow {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }
}
