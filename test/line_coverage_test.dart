import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [LineCoverage] class.
void main() => group("LineCoverage", () {
  group(".fromJson()", () {
    test("should return an instance with default values for an empty map", () {
      final coverage = LineCoverage.fromJson(<String, dynamic>{});
      expect(coverage.data, allOf(isList, isEmpty));
      expect(coverage.found, 0);
      expect(coverage.hit, 0);
    });

    test("should return an initialized instance for a non-empty map", () {
      final coverage = LineCoverage.fromJson(<String, dynamic>{
        "data": [{"lineNumber": 127}],
        "found": 3,
        "hit": 19
      });

      expect(coverage.data, hasLength(1));
      expect(coverage.data.first, isNotNull);
      expect(coverage.found, 3);
      expect(coverage.hit, 19);
    });
  });

  group(".toJson()", () {
    test("should return a map with default values for a newly created instance", () {
      final map = LineCoverage().toJson();
      expect(map, hasLength(3));
      expect(map["data"], allOf(isList, isEmpty));
      expect(map["found"], 0);
      expect(map["hit"], 0);
    });

    test("should return a non-empty map for an initialized instance", () {
      final map = LineCoverage(3, 19, [LineData(0)]).toJson();
      expect(map, hasLength(3));
      expect(map["data"], allOf(isList, hasLength(1)));
      expect(map["data"].first, isMap);
      expect(map["found"], 3);
      expect(map["hit"], 19);
    });
  });

  group(".toString()", () {
    test(r"should return a format like 'LF:<found>\nLH:<hit>'", () {
      expect(LineCoverage().toString(), "LF:0\nLH:0");

      final data = LineData(127, executionCount: 3);
      expect(LineCoverage(3, 19, [data]).toString(), "$data\nLF:3\nLH:19");
    });
  });
});
