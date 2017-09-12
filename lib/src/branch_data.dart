part of lcov;

/// Provides details for branch coverage.
class BranchData {

  /// Creates a new branch data.
  const BranchData({this.lineNumber = 0, this.blockNumber = 0, this.branchNumber = 0, this.taken = 0});

  /// Creates a new branch data from the specified [map] in JSON format.
  BranchData.fromJson(Map<String, int> map):
    blockNumber = map['blockNumber'] ?? 0,
    branchNumber = map['branchNumber'] ?? 0,
    lineNumber = map['lineNumber'] ?? 0,
    taken = map['taken'] ?? 0;

  /// The branch number.
  final int branchNumber;

  /// The block number.
  final int blockNumber;

  /// The line number.
  final int lineNumber;

  /// A number indicating how often this branch was taken.
  final int taken;

  /// Converts this object to a map in JSON format.
  Map<String, int> toJson() => {
    'blockNumber': blockNumber,
    'branchNumber': branchNumber,
    'lineNumber': lineNumber,
    'taken': taken
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var value = '${Token.branchData}:$lineNumber,$blockNumber,$branchNumber';
    return taken > 0 ? '$value,$taken' : '$value,-';
  }
}
