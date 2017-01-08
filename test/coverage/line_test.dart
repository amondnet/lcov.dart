import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the branch coverage.
void main() {
  group('LineCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var coverage = new LineCoverage.fromJson(const {});
        expect(coverage.data, allOf(isList, hasLength(0)));
        expect(coverage.found, equals(0));
        expect(coverage.hit, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var coverage = new LineCoverage.fromJson({
          'data': [const {}],
          'found': 3,
          'hit': 19
        });

        expect(coverage.data, allOf(isList, hasLength(1)));
        expect(coverage.data[0], new isInstanceOf<LineData>());
        expect(coverage.found, equals(3));
        expect(coverage.hit, equals(19));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = new LineCoverage().toJson();
        expect(map, allOf(isMap, hasLength(3)));
        expect(map['data'], allOf(isList, hasLength(0)));
        expect(map['found'], equals(0));
        expect(map['hit'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new LineCoverage(
          data: [new LineData()],
          found: 3,
          hit: 19
        ).toJson();

        expect(map, allOf(isMap, hasLength(3)));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'][0], isMap);
        expect(map['found'], equals(3));
        expect(map['hit'], equals(19));
      });
    });

    group('.toString()', () {
      test(r'should return a format like "LH:<hit>\nLF:<found>"', () {
        var data = new LineCoverage();
        expect(data.toString(), equals('LH:0\nLF:0'));

        data = new LineCoverage(data: [new LineData()], found: 3, hit: 19);
        expect(data.toString(), equals('DA:0,0\nLH:19\nLF:3'));
      });
    });
  });

  group('LineData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var data = new LineData.fromJson(const {});
        expect(data.checksum, isNull);
        expect(data.executionCount, equals(0));
        expect(data.lineNumber, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var data = new LineData.fromJson(const {
          'checksum': 'ed076287532e86365e841e92bfc50d8c',
          'count': 3,
          'line': 127
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
        expect(map['checksum'], isNull);
        expect(map['count'], equals(0));
        expect(map['line'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new LineData(
          checksum: 'ed076287532e86365e841e92bfc50d8c',
          executionCount: 3,
          lineNumber: 127
        ).toJson();

        expect(map, allOf(isMap, hasLength(3)));
        expect(map['checksum'], equals('ed076287532e86365e841e92bfc50d8c'));
        expect(map['count'], equals(3));
        expect(map['line'], equals(127));
      });
    });

    group('.toString()', () {
      test('should return a format like "DA:<lineNumber>,<executionCount>[,<checksum>]"', () {
        var data = new LineData();
        expect(data.toString(), equals('DA:0,0'));

        data = new LineData(checksum: 'ed076287532e86365e841e92bfc50d8c', executionCount: 3, lineNumber: 127);
        expect(data.toString(), equals('DA:127,3,ed076287532e86365e841e92bfc50d8c'));
      });
    });
  });
}
