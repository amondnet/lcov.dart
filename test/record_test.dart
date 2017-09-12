import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Record] class.
void main() => group('Record', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var record = new Record.fromJson(const {});
      expect(record.branches, isNull);
      expect(record.functions, isNull);
      expect(record.lines, isNull);
      expect(record.sourceFile, isEmpty);
    });

    test('should return an initialized instance for a non-empty map', () {
      var record = new Record.fromJson({
        'branches': const {},
        'functions': const {},
        'lines': const {},
        'sourceFile': '/home/cedx/lcov.dart'
      });

      expect(record.branches, const isInstanceOf<BranchCoverage>());
      expect(record.functions, const isInstanceOf<FunctionCoverage>());
      expect(record.lines, const isInstanceOf<LineCoverage>());
      expect(record.sourceFile, equals('/home/cedx/lcov.dart'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new Record('').toJson();
      expect(map, hasLength(4));
      expect(map['branches'], isNull);
      expect(map['functions'], isNull);
      expect(map['lines'], isNull);
      expect(map['sourceFile'], isEmpty);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = (new Record('/home/cedx/lcov.dart')
        ..branches = new BranchCoverage()
        ..functions = new FunctionCoverage()
        ..lines = new LineCoverage()
      ).toJson();

      expect(map, hasLength(4));
      expect(map['branches'], isMap);
      expect(map['functions'], isMap);
      expect(map['lines'], isMap);
      expect(map['sourceFile'], '/home/cedx/lcov.dart');
    });
  });

  group('.toString()', () {
    test(r'should return a format like "SF:<sourceFile>\n,end_of_record"', () {
      expect(new Record('').toString(), equals('SF:\nend_of_record'));

      var record = new Record('/home/cedx/lcov.dart')
        ..branches = new BranchCoverage()
        ..functions = new FunctionCoverage()
        ..lines = new LineCoverage();

      expect(record.toString(), equals('SF:/home/cedx/lcov.dart\n${record.functions}\n${record.branches}\n${record.lines}\nend_of_record'));
    });
  });
});
