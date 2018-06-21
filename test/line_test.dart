import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the line coverage.
void main() {
  group('LineCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var coverage = LineCoverage.fromJson(const <String, dynamic>{});
        expect(coverage.data, allOf(isList, isEmpty));
        expect(coverage.found, equals(0));
        expect(coverage.hit, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var coverage = LineCoverage.fromJson(<String, dynamic>{
          'data': [const {'lineNumber': 127}],
          'found': 3,
          'hit': 19
        });

        expect(coverage.data, allOf(isList, hasLength(1)));
        expect(coverage.data.first, const TypeMatcher<LineData>());
        expect(coverage.found, equals(3));
        expect(coverage.hit, equals(19));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = LineCoverage().toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, isEmpty));
        expect(map['found'], equals(0));
        expect(map['hit'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = LineCoverage(3, 19, [LineData(0)]).toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], equals(3));
        expect(map['hit'], equals(19));
      });
    });

    group('.toString()', () {
      test(r'should return a format like "LF:<found>\nLH:<hit>"', () {
        expect(LineCoverage().toString(), equals('LF:0\nLH:0'));

        var data = LineData(127, executionCount: 3);
        expect(LineCoverage(3, 19, [data]).toString(), equals('$data\nLF:3\nLH:19'));
      });
    });
  });

  group('LineData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var data = LineData.fromJson(const <String, dynamic>{});
        expect(data.checksum, isEmpty);
        expect(data.executionCount, equals(0));
        expect(data.lineNumber, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var data = LineData.fromJson(const <String, dynamic>{
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
        var map = LineData(0).toJson();
        expect(map, hasLength(3));
        expect(map['checksum'], isEmpty);
        expect(map['executionCount'], equals(0));
        expect(map['lineNumber'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = LineData(127, executionCount: 3, checksum: 'ed076287532e86365e841e92bfc50d8c').toJson();
        expect(map, hasLength(3));
        expect(map['checksum'], equals('ed076287532e86365e841e92bfc50d8c'));
        expect(map['executionCount'], equals(3));
        expect(map['lineNumber'], equals(127));
      });
    });

    group('.toString()', () {
      test('should return a format like "DA:<lineNumber>,<executionCount>[,<checksum>]"', () {
        expect(LineData(0).toString(), equals('DA:0,0'));

        var data = LineData(127, executionCount: 3, checksum: 'ed076287532e86365e841e92bfc50d8c');
        expect(data.toString(), equals('DA:127,3,ed076287532e86365e841e92bfc50d8c'));
      });
    });
  });
}
