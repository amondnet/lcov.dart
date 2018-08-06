part of lcov;

/// Converts the specified list of [BranchData] instances to a list of JSON objects.
List<Map<String, dynamic>> _branchDataToJson(List<BranchData> items) => items.map((item) => item.toJson()).toList();

/// Provides the coverage data of branches.
@JsonSerializable()
class BranchCoverage {

  /// Creates a new branch coverage.
  BranchCoverage([this.found = 0, this.hit = 0, Iterable<BranchData> data]): data = List<BranchData>.from(data ?? const <BranchData>[]);

  /// Creates a new branch coverage from the specified [map] in JSON format.
  factory BranchCoverage.fromJson(Map<String, dynamic> map) => _$BranchCoverageFromJson(map);

  /// The coverage data.
  @JsonKey(toJson: _branchDataToJson)
  final List<BranchData> data;

  /// The number of branches found.
  @JsonKey(defaultValue: 0)
  int found;

  /// The number of branches hit.
  @JsonKey(defaultValue: 0)
  int hit;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$BranchCoverageToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer();
    if (data.isNotEmpty) buffer..writeAll(data, '\n')..writeln();
    buffer
      ..writeln('${Token.branchesFound}:$found')
      ..write('${Token.branchesHit}:$hit');

    return buffer.toString();
  }
}

/// Provides details for branch coverage.
@JsonSerializable()
class BranchData {

  /// Creates a new branch data.
  BranchData(this.lineNumber, this.blockNumber, this.branchNumber, {this.taken = 0});

  /// Creates a new branch data from the specified [map] in JSON format.
  factory BranchData.fromJson(Map<String, dynamic> map) => _$BranchDataFromJson(map);

  /// The block number.
  @JsonKey(defaultValue: 0)
  final int blockNumber;

  /// The branch number.
  @JsonKey(defaultValue: 0)
  final int branchNumber;

  /// The line number.
  @JsonKey(defaultValue: 0)
  final int lineNumber;

  /// A number indicating how often this branch was taken.
  @JsonKey(defaultValue: 0)
  int taken;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$BranchDataToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final value = '${Token.branchData}:$lineNumber,$blockNumber,$branchNumber';
    return taken > 0 ? '$value,$taken' : '$value,-';
  }
}
