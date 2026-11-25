import 'package:flutter_test/flutter_test.dart';
import 'package:pro_matrimony/utils/utils.dart';

void main() {
  group('formatDisplayHeight Tests', () {
    test('Hyphenated ft format (API dropdown values)', () {
      expect(formatDisplayHeight('4-8 ft', appendHeight: true), equals('4\'8" Height'));
      expect(formatDisplayHeight('4-8 ft', appendHeight: false), equals('4\'8"'));
      expect(formatDisplayHeight('5-6 ft', appendHeight: true), equals('5\'6" Height'));
      expect(formatDisplayHeight('5-10 ft', appendHeight: true), equals('5\'10" Height'));
      expect(formatDisplayHeight('5-11 ft', appendHeight: true), equals('5\'11" Height'));
      expect(formatDisplayHeight('4-1 ft', appendHeight: true), equals('4\'1" Height'));
    });

    test('cm with feet marker (API dropdown values)', () {
      expect(formatDisplayHeight('122cm - 4', appendHeight: true), equals('4\'0" Height'));
      expect(formatDisplayHeight('122cm - 4', appendHeight: false), equals('4\'0"'));
      expect(formatDisplayHeight('153cm - 5', appendHeight: true), equals('5\'0" Height'));
      expect(formatDisplayHeight('183cm - 6', appendHeight: true), equals('6\'0" Height'));
      expect(formatDisplayHeight('214cm - 7', appendHeight: true), equals('7\'0" Height'));
    });

    test('Standard feet and inches string formats', () {
      expect(formatDisplayHeight('5ft 6in', appendHeight: true), equals('5\'6" Height'));
      expect(formatDisplayHeight('5 ft 6 in', appendHeight: false), equals('5\'6"'));
      expect(formatDisplayHeight('5ft', appendHeight: true), equals('5\'0" Height'));
      expect(formatDisplayHeight('5\'8"', appendHeight: true), equals('5\'8" Height'));
      expect(formatDisplayHeight('5\'8', appendHeight: false), equals('5\'8"'));
    });

    test('Numeric dropdown IDs or total inches', () {
      expect(formatDisplayHeight(56, appendHeight: true), equals('4\'8" Height'));
      expect(formatDisplayHeight(60, appendHeight: true), equals('5\'0" Height'));
      expect(formatDisplayHeight(68, appendHeight: true), equals('5\'8" Height'));
      expect(formatDisplayHeight(72, appendHeight: true), equals('6\'0" Height'));
    });

    test('Null and empty values', () {
      expect(formatDisplayHeight(null), equals(''));
      expect(formatDisplayHeight(''), equals(''));
      expect(formatDisplayHeight('0'), equals(''));
      expect(formatDisplayHeight('N/A'), equals(''));
    });
  });
}
