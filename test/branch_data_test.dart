import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the branch coverage.
void main() => group('BranchData', () {
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
      var map = new BranchData().toJson();
      expect(map, allOf(isMap, hasLength(4)));
      expect(map['blockNumber'], equals(0));
      expect(map['branchNumber'], equals(0));
      expect(map['lineNumber'], equals(0));
      expect(map['taken'], equals(0));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new BranchData(127, 3, 2, 1).toJson();
      expect(map, allOf(isMap, hasLength(4)));
      expect(map['blockNumber'], equals(3));
      expect(map['branchNumber'], equals(2));
      expect(map['lineNumber'], equals(127));
      expect(map['taken'], equals(1));
    });
  });

  group('.toString()', () {
    test('should return a format like "BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>"', () {
      expect(new BranchData().toString(), equals('BRDA:0,0,0,-'));
      expect(new BranchData(127, 3, 2, 1).toString(), equals('BRDA:127,3,2,1'));
    });
  });
});
