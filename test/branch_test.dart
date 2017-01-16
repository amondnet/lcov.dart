import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the branch coverage.
void main() {
  group('BranchCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var coverage = new BranchCoverage.fromJson(const {});
        expect(coverage.data, allOf(isList, hasLength(0)));
        expect(coverage.found, equals(0));
        expect(coverage.hit, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var coverage = new BranchCoverage.fromJson({
          'data': const [const {}],
          'found': 3,
          'hit': 19
        });

        expect(coverage.data, allOf(isList, hasLength(1)));
        expect(coverage.data.first, new isInstanceOf<BranchData>());
        expect(coverage.found, equals(3));
        expect(coverage.hit, equals(19));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = new BranchCoverage().toJson();
        expect(map, allOf(isMap, hasLength(3)));
        expect(map['data'], allOf(isList, hasLength(0)));
        expect(map['found'], equals(0));
        expect(map['hit'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new BranchCoverage(
          data: [new BranchData()],
          found: 3,
          hit: 19
        ).toJson();

        expect(map, allOf(isMap, hasLength(3)));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], equals(3));
        expect(map['hit'], equals(19));
      });
    });

    group('.toString()', () {
      test(r'should return a format like "BRF:<found>\nBRH:<hit>"', () {
        var data = new BranchCoverage();
        expect(data.toString(), equals('BRF:0\nBRH:0'));

        data = new BranchCoverage(data: [new BranchData()], found: 3, hit: 19);
        expect(data.toString(), equals('BRDA:0,0,0,-\nBRF:3\nBRH:19'));
      });
    });
  });

  group('BranchData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var data = new BranchData.fromJson(const {});
        expect(data.branchNumber, equals(0));
        expect(data.blockNumber, equals(0));
        expect(data.lineNumber, equals(0));
        expect(data.taken, equals(0));
      });

      test('should return an initialized instance for a non-empty map', () {
        var data = new BranchData.fromJson(const {
          'block': 3,
          'branch': 2,
          'line': 127,
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
        var map = new BranchData().toJson();
        expect(map, allOf(isMap, hasLength(4)));
        expect(map['block'], equals(0));
        expect(map['branch'], equals(0));
        expect(map['line'], equals(0));
        expect(map['taken'], equals(0));
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new BranchData(
          branchNumber: 2,
          blockNumber: 3,
          lineNumber: 127,
          taken: 1
        ).toJson();

        expect(map, allOf(isMap, hasLength(4)));
        expect(map['block'], equals(3));
        expect(map['branch'], equals(2));
        expect(map['line'], equals(127));
        expect(map['taken'], equals(1));
      });
    });

    group('.toString()', () {
      test('should return a format like "BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>"', () {
        var data = new BranchData();
        expect(data.toString(), equals('BRDA:0,0,0,-'));

        data = new BranchData(branchNumber: 2, blockNumber: 3, lineNumber: 127, taken: 1);
        expect(data.toString(), equals('BRDA:127,3,2,1'));
      });
    });
  });
}
