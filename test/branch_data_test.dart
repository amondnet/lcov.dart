import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [BranchData] class.
void main() => group("BranchData", () {
  group(".fromJson()", () {
    test("should return an instance with default values for an empty map", () {
      final data = BranchData.fromJson({});
      expect(data.branchNumber, 0);
      expect(data.blockNumber, 0);
      expect(data.lineNumber, 0);
      expect(data.taken, 0);
    });

    test("should return an initialized instance for a non-empty map", () {
      final data = BranchData.fromJson({
        "blockNumber": 3,
        "branchNumber": 2,
        "lineNumber": 127,
        "taken": 1
      });

      expect(data.branchNumber, 2);
      expect(data.blockNumber, 3);
      expect(data.lineNumber, 127);
      expect(data.taken, 1);
    });
  });

  group(".toJson()", () {
    test("should return a map with default values for a newly created instance", () {
      final map = BranchData(0, 0, 0).toJson();
      expect(map, hasLength(4));
      expect(map["blockNumber"], 0);
      expect(map["branchNumber"], 0);
      expect(map["lineNumber"], 0);
      expect(map["taken"], 0);
    });

    test("should return a non-empty map for an initialized instance", () {
      final map = BranchData(127, 3, 2, taken: 1).toJson();
      expect(map, hasLength(4));
      expect(map["blockNumber"], 3);
      expect(map["branchNumber"], 2);
      expect(map["lineNumber"], 127);
      expect(map["taken"], 1);
    });
  });

  group(".toString()", () {
    test("should return a format like 'BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>'", () {
      expect(BranchData(0, 0, 0).toString(), "BRDA:0,0,0,-");
      expect(BranchData(127, 3, 2, taken: 1).toString(), "BRDA:127,3,2,1");
    });
  });
});
