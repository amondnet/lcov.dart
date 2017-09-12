import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the function coverage.
void main() => group('FunctionData', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var data = new FunctionData.fromJson(const {});
      expect(data.executionCount, equals(0));
      expect(data.functionName, isEmpty);
      expect(data.lineNumber, equals(0));
    });

    test('should return an initialized instance for a non-empty map', () {
      var data = new FunctionData.fromJson(const {
        'executionCount': 3,
        'functionName': 'main',
        'lineNumber': 127
      });

      expect(data.executionCount, equals(3));
      expect(data.functionName, equals('main'));
      expect(data.lineNumber, equals(127));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new FunctionData('', 0).toJson();
      expect(map, hasLength(3));
      expect(map['executionCount'], equals(0));
      expect(map['functionName'], isEmpty);
      expect(map['lineNumber'], equals(0));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new FunctionData('main', 127, executionCount: 3).toJson();
      expect(map, hasLength(3));
      expect(map['executionCount'], equals(3));
      expect(map['functionName'], equals('main'));
      expect(map['lineNumber'], equals(127));
    });
  });

  group('.toString()', () {
    test('should return a format like "FN:<lineNumber>,<functionName>" when used as definition', () {
      expect(new FunctionData('', 0).toString(asDefinition: true), equals('FN:0,'));
      expect(new FunctionData('main', 127, executionCount: 3).toString(asDefinition: true), equals('FN:127,main'));
    });

    test('should return a format like "FNDA:<executionCount>,<functionName>" when used as data', () {
      expect(new FunctionData('', 0).toString(asDefinition: false), equals('FNDA:0,'));
      expect(new FunctionData('main', 127, executionCount: 3).toString(asDefinition: false), equals('FNDA:3,main'));
    });
  });
});
