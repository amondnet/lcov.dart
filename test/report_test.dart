import 'dart:io';
import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Report] class.
void main() {
  group('Report', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var report = new Report.fromJson(const {});
        expect(report.records, allOf(isList, isEmpty));
        expect(report.testName, isEmpty);
      });

      test('should return an initialized instance for a non-empty map', () {
        var report = new Report.fromJson({
          'records': [const {}],
          'testName': 'LcovTest'
        });

        expect(report.records, allOf(isList, hasLength(1)));
        expect(report.records.first, new isInstanceOf<Record>());
        expect(report.testName, equals('LcovTest'));
      });
    });

    group('.parse()', () {
      var report = Report.parse(new File('test/lcov.info').readAsStringSync());

      test('should have a test name', () {
        expect(report.testName, equals('Example'));
      });

      test('should contain three records', () {
        expect(report.records, allOf(isList, hasLength(3)));
        expect(report.records.first, new isInstanceOf<Record>());
        expect(report.records[0].sourceFile, equals('/home/cedx/lcov.dart/fixture.dart'));
        expect(report.records[1].sourceFile, equals('/home/cedx/lcov.dart/func1.dart'));
        expect(report.records[2].sourceFile, equals('/home/cedx/lcov.dart/func2.dart'));
      });

      test('should have detailed branch coverage', () {
        var branches = report.records[1].branches;
        expect(branches.found, equals(4));
        expect(branches.hit, equals(4));

        expect(branches.data, allOf(isList, hasLength(4)));
        expect(branches.data.first, new isInstanceOf<BranchData>());
        expect(branches.data.first.lineNumber, equals(8));
      });

      test('should have detailed function coverage', () {
        var functions = report.records[1].functions;
        expect(functions.found, equals(1));
        expect(functions.hit, equals(1));

        expect(functions.data, allOf(isList, hasLength(1)));
        expect(functions.data.first, new isInstanceOf<FunctionData>());
        expect(functions.data.first.functionName, equals('func1'));
      });

      test('should have detailed line coverage', () {
        var lines = report.records[1].lines;
        expect(lines.found, equals(9));
        expect(lines.hit, equals(9));

        expect(lines.data, allOf(isList, hasLength(9)));
        expect(lines.data.first, new isInstanceOf<LineData>());
        expect(lines.data.first.checksum, equals('5kX7OTfHFcjnS98fjeVqNA'));
      });

      test('should throw an error if the input is invalid', () {
        expect(() => Report.parse('TN:Example'), throwsFormatException);
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = new Report().toJson();
        expect(map, allOf(isMap, hasLength(2)));
        expect(map['records'], allOf(isList, isEmpty));
        expect(map['testName'], isEmpty);
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new Report('LcovTest', [new Record()]).toJson();
        expect(map, allOf(isMap, hasLength(2)));
        expect(map['records'], allOf(isList, hasLength(1)));
        expect(map['records'].first, isMap);
        expect(map['testName'], 'LcovTest');
      });
    });

    group('.toString()', () {
      test('should return a format like "TN:<testName>"', () {
        expect(new Report().toString(), isEmpty);

        var record = new Record();
        expect(new Report('LcovTest', [record]).toString(), equals('TN:LcovTest\n$record'));
      });
    });
  });
}
