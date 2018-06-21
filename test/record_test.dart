import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Record] class.
void main() => group('Record', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var record = Record.fromJson(<String, dynamic>{});
      expect(record.branches, isNull);
      expect(record.functions, isNull);
      expect(record.lines, isNull);
      expect(record.sourceFile, isEmpty);
    });

    test('should return an initialized instance for a non-empty map', () {
      var record = Record.fromJson(<String, dynamic>{
        'branches': <String, dynamic>{},
        'functions': <String, dynamic>{},
        'lines': <String, dynamic>{},
        'sourceFile': '/home/cedx/lcov.dart'
      });

      expect(record.branches, const TypeMatcher<BranchCoverage>());
      expect(record.functions, const TypeMatcher<FunctionCoverage>());
      expect(record.lines, const TypeMatcher<LineCoverage>());
      expect(record.sourceFile, equals('/home/cedx/lcov.dart'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = Record('').toJson();
      expect(map, hasLength(4));
      expect(map['branches'], isNull);
      expect(map['functions'], isNull);
      expect(map['lines'], isNull);
      expect(map['sourceFile'], isEmpty);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = (Record('/home/cedx/lcov.dart')
        ..branches = BranchCoverage()
        ..functions = FunctionCoverage()
        ..lines = LineCoverage()
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
      expect(Record('').toString(), equals('SF:\nend_of_record'));

      var record = Record('/home/cedx/lcov.dart')
        ..branches = BranchCoverage()
        ..functions = FunctionCoverage()
        ..lines = LineCoverage();

      expect(record.toString(), equals('SF:/home/cedx/lcov.dart\n${record.functions}\n${record.branches}\n${record.lines}\nend_of_record'));
    });
  });
});
