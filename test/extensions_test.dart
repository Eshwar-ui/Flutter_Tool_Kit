import 'package:flutter_app_utilities/flutter_app_utilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions', () {
    test('normalizes and title cases strings', () {
      expect('  hello   world '.normalizedSpaces, 'hello world');
      expect('hello world'.titleCased, 'Hello World');
      expect('   '.isBlank, isTrue);
    });

    test('handles nullable strings', () {
      const String? missing = null;

      expect(missing.isNullOrBlank, isTrue);
      expect('  '.nullIfBlank, isNull);
      expect(' value '.nullIfBlank, ' value ');
    });
  });

  group('IterableExtensions', () {
    test('finds nullable first values', () {
      expect(<int>[].firstOrNull, isNull);
      expect(<int>[1, 2].firstOrNull, 1);
      expect(<int>[1, 2].firstWhereOrNull((int value) => value > 1), 2);
    });

    test('maps with index and separates values', () {
      expect(
        <String>[
          'a',
          'b',
        ].mapIndexed<String>((int index, String value) => '$index:$value'),
        <String>['0:a', '1:b'],
      );
      expect(<String>['a', 'b', 'c'].separatedBy('|'), <String>[
        'a',
        '|',
        'b',
        '|',
        'c',
      ]);
    });
  });

  test('DateTimeExtensions compares calendar days', () {
    final DateTime morning = DateTime(2026, 5, 31, 8);
    final DateTime evening = DateTime(2026, 5, 31, 20);

    expect(morning.isSameDay(evening), isTrue);
    expect(morning.startOfDay, DateTime(2026, 5, 31));
  });
}
