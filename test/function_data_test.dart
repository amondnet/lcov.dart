import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [FunctionData] class.
void main() => group("FunctionData", () {
  group(".fromJson()", () {
    test("should return an instance with default values for an empty map", () {
      final data = FunctionData.fromJson(<String, dynamic>{});
      expect(data.executionCount, 0);
      expect(data.functionName, isEmpty);
      expect(data.lineNumber, 0);
    });

    test("should return an initialized instance for a non-empty map", () {
      final data = FunctionData.fromJson(<String, dynamic>{
        "executionCount": 3,
        "functionName": "main",
        "lineNumber": 127
      });

      expect(data.executionCount, 3);
      expect(data.functionName, "main");
      expect(data.lineNumber, 127);
    });
  });

  group(".toJson()", () {
    test("should return a map with default values for a newly created instance", () {
      final map = FunctionData("", 0).toJson();
      expect(map, hasLength(3));
      expect(map["executionCount"], 0);
      expect(map["functionName"], isEmpty);
      expect(map["lineNumber"], 0);
    });

    test("should return a non-empty map for an initialized instance", () {
      final map = FunctionData("main", 127, executionCount: 3).toJson();
      expect(map, hasLength(3));
      expect(map["executionCount"], 3);
      expect(map["functionName"], "main");
      expect(map["lineNumber"], 127);
    });
  });

  group(".toString()", () {
    test("should return a format like 'FN:<lineNumber>,<functionName>' when used as definition", () {
      expect(FunctionData("", 0).toString(asDefinition: true), "FN:0,");
      expect(FunctionData("main", 127, executionCount: 3).toString(asDefinition: true), "FN:127,main");
    });

    test("should return a format like 'FNDA:<executionCount>,<functionName>' when used as data", () {
      expect(FunctionData("", 0).toString(asDefinition: false), "FNDA:0,");
      expect(FunctionData("main", 127, executionCount: 3).toString(asDefinition: false), "FNDA:3,main");
    });
  });
});
