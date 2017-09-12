part of lcov;

/// Provides details for line coverage.
class LineData {

  /// Creates a new line data.
  const LineData(this.lineNumber, this.executionCount, {this.checksum = ''});

  /// Creates a new line data from the specified [map] in JSON format.
  LineData.fromJson(Map<String, dynamic> map):
    checksum = map['checksum'] is String ? map['checksum'] : '',
    executionCount = map['executionCount'] is int ? map['executionCount'] : 0,
    lineNumber = map['lineNumber'] is int ? map['lineNumber'] : 0;

  /// The data checksum.
  final String checksum;

  /// The execution count.
  final int executionCount;

  /// The line number.
  final int lineNumber;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'checksum': checksum,
    'executionCount': executionCount,
    'lineNumber': lineNumber
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var value = '${Token.lineData}:$lineNumber,$executionCount';
    return checksum.isEmpty ? value : '$value,$checksum';
  }
}
