import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the line coverage.
void main() {
  group('Record', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map', () {
        var record = new Record.fromJson(const {});
        expect(record.branches, isNull);
        expect(record.functions, isNull);
        expect(record.lines, isNull);
        expect(record.sourceFile, isNull);
      });

      test('should return an initialized instance for a non-empty map', () {
        var record = new Record.fromJson(const {
          'branches': const {},
          'functions': const {},
          'lines': const {},
          'sourceFile': '/home/cedx/lcov.dart'
        });

        expect(record.branches, new isInstanceOf<BranchCoverage>());
        expect(record.functions, new isInstanceOf<FunctionCoverage>());
        expect(record.lines, new isInstanceOf<LineCoverage>());
        expect(record.sourceFile, equals('/home/cedx/lcov.dart'));
      });
    });

    group('.toJson()', () {
      test('should return a map with default values for a newly created instance', () {
        var map = new Record().toJson();
        expect(map, allOf(isMap, hasLength(4)));
        expect(map['branches'], isNull);
        expect(map['functions'], isNull);
        expect(map['lines'], isNull);
        expect(map['sourceFile'], isNull);
      });

      test('should return a non-empty map for an initialized instance', () {
        var map = new Record(
          branches: new BranchCoverage(),
          functions: new FunctionCoverage(),
          lines: new LineCoverage(),
          sourceFile: '/home/cedx/lcov.dart'
        ).toJson();

        expect(map, allOf(isMap, hasLength(4)));
        expect(map['branches'], isMap);
        expect(map['functions'], isMap);
        expect(map['lines'], isMap);
        expect(map['sourceFile'], '/home/cedx/lcov.dart');
      });
    });

    group('.toString()', () {
      test(r'should return a format like "SF:<sourceFile>\n,end_of_record"', () {
        var record = new Record();
        expect(record.toString(), equals('SF:null\nend_of_record'));

        var branches = new BranchCoverage();
        var functions = new FunctionCoverage();
        var lines = new LineCoverage();
        record = new Record(branches: branches, functions: functions, lines: lines, sourceFile: '/home/cedx/lcov.dart');
        expect(record.toString(), equals('SF:/home/cedx/lcov.dart\n$functions\n$branches\n$lines\nend_of_record'));
      });
    });
  });
}
