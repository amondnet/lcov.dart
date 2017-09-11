import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the line coverage.
void main() => group('LineData', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var data = new LineData.fromJson(const {});
      expect(data.checksum, isEmpty);
      expect(data.executionCount, equals(0));
      expect(data.lineNumber, equals(0));
    });

    test('should return an initialized instance for a non-empty map', () {
      var data = new LineData.fromJson(const {
        'checksum': 'ed076287532e86365e841e92bfc50d8c',
        'executionCount': 3,
        'lineNumber': 127
      });

      expect(data.checksum, equals('ed076287532e86365e841e92bfc50d8c'));
      expect(data.executionCount, equals(3));
      expect(data.lineNumber, equals(127));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new LineData().toJson();
      expect(map, allOf(isMap, hasLength(3)));
      expect(map['checksum'], isEmpty);
      expect(map['executionCount'], equals(0));
      expect(map['lineNumber'], equals(0));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new LineData(127, 3, 'ed076287532e86365e841e92bfc50d8c').toJson();
      expect(map, allOf(isMap, hasLength(3)));
      expect(map['checksum'], equals('ed076287532e86365e841e92bfc50d8c'));
      expect(map['executionCount'], equals(3));
      expect(map['lineNumber'], equals(127));
    });
  });

  group('.toString()', () {
    test('should return a format like "DA:<lineNumber>,<executionCount>[,<checksum>]"', () {
      expect(new LineData().toString(), equals('DA:0,0'));
      expect(new LineData(127, 3, 'ed076287532e86365e841e92bfc50d8c').toString(), equals('DA:127,3,ed076287532e86365e841e92bfc50d8c'));
    });
  });
});
