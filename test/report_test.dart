import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Report] class.
void main() => group('Report', () {
  const coverage = '''
TN:Example

SF:/home/cedx/lcov.dart/fixture.dart
FN:4,main
FNDA:2,main
FNF:1
FNH:1
DA:6,2,PF4Rz2r7RTliO9u6bZ7h6g
DA:7,2,yGMB6FhEEAd8OyASe3Ni1w
DA:8,2,8F2cpOfOtP7xrzoeUaNfTg
DA:9,2,y7GE3Y4FyXCeXcrtqgSVzw
LF:4
LH:4
end_of_record

SF:/home/cedx/lcov.dart/func1.dart
FN:5,func1
FNDA:4,func1
FNF:1
FNH:1
BRDA:8,0,0,2
BRDA:8,0,1,2
BRDA:11,0,0,2
BRDA:11,0,1,2
BRF:4
BRH:4
DA:7,4,5kX7OTfHFcjnS98fjeVqNA
DA:8,4,Z0wAKBAY/gWvszzK23gPjg
DA:9,2,axfyTWsiE2y4xhwLfts4Hg
DA:10,2,fu+5DeZoKYnvkzvK3Lt96Q
DA:11,4,RY9SlOU8MfTJFeL6YlmwVQ
DA:12,2,ZHrTdJHnvMtpEN3wqQEqbw
DA:13,2,fu+5DeZoKYnvkzvK3Lt96Q
DA:14,4,7/m6ZIVdeOR9WTEt9UzqSA
DA:15,4,y7GE3Y4FyXCeXcrtqgSVzw
LF:9
LH:9
end_of_record

SF:/home/cedx/lcov.dart/func2.dart
FN:5,func2
FNDA:2,func2
FNF:1
FNH:1
BRDA:8,0,0,2
BRDA:8,0,1,0
BRDA:11,0,0,0
BRDA:11,0,1,2
BRF:4
BRH:2
DA:7,2,5kX7OTfHFcjnS98fjeVqNA
DA:8,2,Z0wAKBAY/gWvszzK23gPjg
DA:9,2,axfyTWsiE2y4xhwLfts4Hg
DA:10,2,fu+5DeZoKYnvkzvK3Lt96Q
DA:11,2,RY9SlOU8MfTJFeL6YlmwVQ
DA:12,0,ZHrTdJHnvMtpEN3wqQEqbw
DA:13,0,fu+5DeZoKYnvkzvK3Lt96Q
DA:14,2,7/m6ZIVdeOR9WTEt9UzqSA
DA:15,2,y7GE3Y4FyXCeXcrtqgSVzw
LF:9
LH:7
end_of_record
''';

  group('.fromCoverage()', () {
    var report = Report.fromCoverage(coverage);

    test('should have a test name', () {
      expect(report.testName, equals('Example'));
    });

    test('should contain three records', () {
      expect(report.records, allOf(isList, hasLength(3)));
      expect(report.records.first, const TypeMatcher<Record>());
      expect(report.records[0].sourceFile, equals('/home/cedx/lcov.dart/fixture.dart'));
      expect(report.records[1].sourceFile, equals('/home/cedx/lcov.dart/func1.dart'));
      expect(report.records[2].sourceFile, equals('/home/cedx/lcov.dart/func2.dart'));
    });

    test('should have detailed branch coverage', () {
      var branches = report.records[1].branches;
      expect(branches.found, equals(4));
      expect(branches.hit, equals(4));

      expect(branches.data, allOf(isList, hasLength(4)));
      expect(branches.data.first, const TypeMatcher<BranchData>());
      expect(branches.data.first.lineNumber, equals(8));
    });

    test('should have detailed function coverage', () {
      var functions = report.records[1].functions;
      expect(functions.found, equals(1));
      expect(functions.hit, equals(1));

      expect(functions.data, allOf(isList, hasLength(1)));
      expect(functions.data.first, const TypeMatcher<FunctionData>());
      expect(functions.data.first.functionName, equals('func1'));
    });

    test('should have detailed line coverage', () {
      var lines = report.records[1].lines;
      expect(lines.found, equals(9));
      expect(lines.hit, equals(9));

      expect(lines.data, allOf(isList, hasLength(9)));
      expect(lines.data.first, const TypeMatcher<LineData>());
      expect(lines.data.first.checksum, equals('5kX7OTfHFcjnS98fjeVqNA'));
    });

    test('should throw an error if the input is invalid', () {
      expect(() => Report.fromCoverage('ZZ'), throwsA(const TypeMatcher<LcovException>()));
    });

    test('should throw an error if the report is empty', () {
      expect(() => Report.fromCoverage('TN:Example'), throwsA(const TypeMatcher<LcovException>()));
    });
  });

  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var report = Report.fromJson(<String, dynamic>{});
      expect(report.records, allOf(isList, isEmpty));
      expect(report.testName, isEmpty);
    });

    test('should return an initialized instance for a non-empty map', () {
      var report = Report.fromJson(<String, dynamic>{
        'records': [<String, dynamic>{}],
        'testName': 'LcovTest'
      });

      expect(report.records, allOf(isList, hasLength(1)));
      expect(report.records.first, const TypeMatcher<Record>());
      expect(report.testName, equals('LcovTest'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = Report().toJson();
      expect(map, hasLength(2));
      expect(map['records'], allOf(isList, isEmpty));
      expect(map['testName'], isEmpty);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = Report('LcovTest', [Record('')]).toJson();
      expect(map, hasLength(2));
      expect(map['records'], allOf(isList, hasLength(1)));
      expect(map['records'].first, isMap);
      expect(map['testName'], 'LcovTest');
    });
  });

  group('.toString()', () {
    test('should return a format like "TN:<testName>"', () {
      expect(Report().toString(), isEmpty);

      var record = Record('');
      expect(Report('LcovTest', [record]).toString(), equals('TN:LcovTest\n$record'));
    });
  });
});
