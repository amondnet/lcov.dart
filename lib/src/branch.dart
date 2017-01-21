part of lcov;

/// Provides the coverage data of branches.
class BranchCoverage {

  /// Creates a new branch coverage.
  BranchCoverage([this.found = 0, this.hit = 0]);

  /// Creates a new branch coverage from the specified [map] in JSON format.
  BranchCoverage.fromJson(Map<String, dynamic> map) {
    if (map['data'] is List<Map<String, int>>) data.addAll(map['data'].map((item) => new BranchData.fromJson(item)));
    found = map['found'] is int ? map['found'] : 0;
    hit = map['hit'] is int ? map['hit'] : 0;
  }

  /// The coverage data.
  final List<BranchData> data = [];

  /// The number of branches found.
  int found;

  /// The number of branches hit.
  int hit;

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
  BranchData([this.lineNumber = 0, this.blockNumber = 0, this.branchNumber = 0, this.taken = 0]);

  /// Creates a new branch data from the specified [map] in JSON format.
  BranchData.fromJson(Map<String, int> map):
    blockNumber = map['blockNumber'] ?? 0,
    branchNumber = map['branchNumber'] ?? 0,
    lineNumber = map['lineNumber'] ?? 0,
    taken = map['taken'] ?? 0;

  /// The branch number.
  int branchNumber;

  /// The block number.
  int blockNumber;

  /// The line number.
  int lineNumber;

  /// A number indicating how often this branch was taken.
  int taken;

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
