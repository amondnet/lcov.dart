part of lcov;

/// Provides the coverage data of branches.
class BranchCoverage {

  /// Creates a new branch coverage.
  BranchCoverage();

  /// Creates a new branch coverage from the specified [map] in JSON format.
  BranchCoverage.fromJson(Map<String, dynamic> map) {
    if (map['data'] is List<Map<String, int>>) data.addAll(map['data'].map((item) => new BranchData.fromJson(item)));
    if (map['found'] is int) found = map['found'];
    if (map['hit'] is int) hit = map['hit'];
  }

  /// The coverage data.
  final List<BranchData> data = [];

  /// The number of branches found.
  int found = 0;

  /// The number of branches hit.
  int hit = 0;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'data': data.map((item) => item.toJson()).toList(),
    'found': found,
    'hit': hit
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = new StringBuffer();
    if (data.isNotEmpty) buffer..writeAll(data, '\n')..writeln();
    buffer.writeln('${Token.branchesFound}:$found');
    buffer.write('${Token.branchesHit}:$hit');
    return buffer.toString();
  }
}

/// Provides details for branch coverage.
class BranchData {

  /// Creates a new branch data.
  BranchData();

  /// Creates a new branch data from the specified [map] in JSON format.
  BranchData.fromJson(Map<String, int> map):
    blockNumber = map['blockNumber'] ?? 0,
    branchNumber = map['branchNumber'] ?? 0,
    lineNumber = map['lineNumber'] ?? 0,
    taken = map['taken'] ?? 0;

  /// The branch number.
  int branchNumber = 0;

  /// The block number.
  int blockNumber = 0;

  /// The line number.
  int lineNumber = 0;

  /// A number indicating how often this branch was taken.
  int taken = 0;

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
