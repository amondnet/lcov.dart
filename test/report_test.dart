import 'dart:io';
import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Report] class.
void main() {
  group('Report', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var report = new Report.fromJson(const {});
        expect(report.records, allOf(isList, hasLength(0)));
        expect(report.testName, isNull);
      });

      test('should return an initialized instance for a non-empty map', () {
        var report = new Report.fromJson(const {
          'records': const [const {}],
          'testName': 'LcovTest'
        });

        expect(report.records, allOf(isList, hasLength(1)));
        expect(report.records[0], new isInstanceOf<Record>());
        expect(report.testName, equals('LcovTest'));
      });
    });

    group('.parse()', () {
      // TODO Try to resolve the 'lcov.info' absolute path.
      var report = Report.parse(new File('test/lcov.info').readAsStringSync());

      test('should have a test name', () {
        expect(report.testName, equals('Example'));
      });

      test('should contain three records', () {
        expect(report.records.length, equals(3));
        expect(report.records[0], new isInstanceOf<Record>());
        expect(report.records[0].sourceFile, equals('/home/cedx/lcov.dart/fixture.dart'));
        expect(report.records[1].sourceFile, equals('/home/cedx/lcov.dart/func1.dart'));
        expect(report.records[2].sourceFile, equals('/home/cedx/lcov.dart/func2.dart'));
      });

      test('should have detailed branch coverage', () {
        var branches = report.records[1].branches;
        expect(branches.found, equals(4));
        expect(branches.hit, equals(4));

        expect(branches.data.length, equals(4));
        expect(branches.data[0], new isInstanceOf<BranchData>());
        expect(branches.data[0].lineNumber, equals(8));
      });

      test('should have detailed function coverage', () {
        var functions = report.records[1].functions;
        expect(functions.found, equals(1));
        expect(functions.hit, equals(1));

        expect(functions.data.length, equals(1));
        expect(functions.data[0], new isInstanceOf<FunctionData>());
        expect('func1', functions.data[0].functionName);
      });

      test('should have detailed line coverage', () {
        var lines = report.records[1].lines;
        expect(lines.found, equals(9));
        expect(lines.hit, equals(9));

        expect(lines.data.length, equals(9));
        expect(lines.data[0], new isInstanceOf<LineData>());
        expect(lines.data[0].checksum, equals('5kX7OTfHFcjnS98fjeVqNA'));
      });

      test('should throw an error if the input is invalid', () {
        expect(() => Report.parse('TN:Example'), throwsFormatException);
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = new Report().toJson();
        expect(map, allOf(isMap, hasLength(2)));
        expect(map['records'], allOf(isList, hasLength(0)));
        expect(map['testName'], isNull);
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new Report(
          records: [new Record()],
          testName: 'LcovTest'
        ).toJson();

        expect(map, allOf(isMap, hasLength(2)));
        expect(map['records'], allOf(isList, hasLength(1)));
        expect(map['records'].first, isMap);
        expect(map['testName'], 'LcovTest');
      });
    });

    group('.toString()', () {
      test('should return a format like "TN:<testName>"', () {
        var report = new Report();
        expect(report.toString(), equals('TN:null'));

        var record = new Record();
        report = new Report(records: [record], testName: 'LcovTest');
        expect(report.toString(), equals('TN:LcovTest\n$record'));
      });
    });
  });
}
