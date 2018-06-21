part of lcov;

/// Provides the coverage data of branches.
class BranchCoverage {

  /// Creates a new branch coverage.
  BranchCoverage([this.found = 0, this.hit = 0, List<BranchData> data]): data = List.from(data ?? const <BranchData>[]);

  /// Creates a new branch coverage from the specified [map] in JSON format.
  BranchCoverage.fromJson(Map<String, dynamic> map):
    data = map['data'] is List<Map<String, int>> ? map['data'].map((item) => BranchData.fromJson(item)).toList() : [],
    found = map['found'] is int ? map['found'] : 0,
    hit = map['hit'] is int ? map['hit'] : 0;

  /// The coverage data.
  final List<BranchData> data;

  /// The number of branches found.
  int found;

  /// The number of branches hit.
  int hit;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'found': found,
    'hit': hit,
    'data': data.map((item) => item.toJson()).toList()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = StringBuffer();
    if (data.isNotEmpty) buffer..writeAll(data, '\n')..writeln();
    buffer
      ..writeln('${Token.branchesFound}:$found')
      ..write('${Token.branchesHit}:$hit');

    return buffer.toString();
  }
}

/// Provides details for branch coverage.
class BranchData {

  /// Creates a new branch data.
  BranchData(this.lineNumber, this.blockNumber, this.branchNumber, {this.taken = 0});

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
  int taken;

  /// Converts this object to a map in JSON format.
  Map<String, int> toJson() => {
    'lineNumber': lineNumber,
    'blockNumber': blockNumber,
    'branchNumber': branchNumber,
    'taken': taken
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var value = '${Token.branchData}:$lineNumber,$blockNumber,$branchNumber';
    return taken > 0 ? '$value,$taken' : '$value,-';
  }
}
