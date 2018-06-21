import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the branch coverage.
void main() {
  group('BranchCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var coverage = BranchCoverage.fromJson(const <String, dynamic>{});
        expect(coverage.data, allOf(isList, isEmpty));
        expect(coverage.found, equals(0));
        expect(coverage.hit, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var coverage = BranchCoverage.fromJson(<String, dynamic>{
          'data': [const {'lineNumber': 127}],
          'found': 3,
          'hit': 19
        });

        expect(coverage.data, allOf(isList, hasLength(1)));
        expect(coverage.data.first, const TypeMatcher<BranchData>());
        expect(coverage.found, equals(3));
        expect(coverage.hit, equals(19));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = BranchCoverage().toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, isEmpty));
        expect(map['found'], equals(0));
        expect(map['hit'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = BranchCoverage(3, 19, [BranchData(0, 0, 0)]).toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], equals(3));
        expect(map['hit'], equals(19));
      });
    });

    group('.toString()', () {
      test(r'should return a format like "BRF:<found>\nBRH:<hit>"', () {
        expect(BranchCoverage().toString(), equals('BRF:0\nBRH:0'));

        var data = BranchData(127, 3, 2);
        expect(BranchCoverage(3, 19, [data]).toString(), equals('$data\nBRF:3\nBRH:19'));
      });
    });
  });

  group('BranchData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var data = BranchData.fromJson(const {});
        expect(data.branchNumber, equals(0));
        expect(data.blockNumber, equals(0));
        expect(data.lineNumber, equals(0));
        expect(data.taken, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var data = BranchData.fromJson(const {
          'blockNumber': 3,
          'branchNumber': 2,
          'lineNumber': 127,
          'taken': 1
        });

        expect(data.branchNumber, equals(2));
        expect(data.blockNumber, equals(3));
        expect(data.lineNumber, equals(127));
        expect(data.taken, equals(1));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = BranchData(0, 0, 0).toJson();
        expect(map, hasLength(4));
        expect(map['blockNumber'], equals(0));
        expect(map['branchNumber'], equals(0));
        expect(map['lineNumber'], equals(0));
        expect(map['taken'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = BranchData(127, 3, 2, taken: 1).toJson();
        expect(map, hasLength(4));
        expect(map['blockNumber'], equals(3));
        expect(map['branchNumber'], equals(2));
        expect(map['lineNumber'], equals(127));
        expect(map['taken'], equals(1));
      });
    });

    group('.toString()', () {
      test('should return a format like "BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>"', () {
        expect(BranchData(0, 0, 0).toString(), equals('BRDA:0,0,0,-'));
        expect(BranchData(127, 3, 2, taken: 1).toString(), equals('BRDA:127,3,2,1'));
      });
    });
  });
}
