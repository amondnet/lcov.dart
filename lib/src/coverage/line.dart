part of lcov;

/// Provides the coverage data of lines.
class LineCoverage {

  /// Creates a new line coverage.
  LineCoverage({this.data = const [], this.found = 0, this.hit = 0});

  /// Creates a new line coverage from the specified [map] in JSON format.
  LineCoverage.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    data = map['details'] is List<Map<String, dynamic>> ? map['details'].map((map) => new LineData.fromJson(map)).toList() : [];
    found = map['found'] != null && map['found'] is int ? map['found'] : 0;
    hit = map['hit'] != null && map['hit'] is int ? map['hit'] : 0;
  }

  /// The coverage data.
  List<LineData> data;

  /// The number of instrumented lines.
  int found;

  /// The number of lines with a non-zero execution count.
  int hit;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'details': data != null ? data.map((item) => item.toJson()).toList() : [],
    'found': found,
    'hit': hit
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var lines = [];
    if (data != null) lines.addAll(data.map((item) => item.toString()));
    lines.add('${Token.linesFound}:$found');
    lines.add('${Token.linesHit}:$hit');
    return lines.join('\n');
  }
}

/// Provides details for line coverage.
class LineData {

  /// Creates a new line data.
  LineData({this.checksum, this.executionCount = 0, this.lineNumber = 0});

  /// Creates a new line data from the specified [map] in JSON format.
  LineData.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    checksum = map['checksum'] != null ? map['checksum'].toString() : null;
    executionCount = map['hit'] is int ? map['hit'] : 0;
    lineNumber = map['line'] is int ? map['line'] : 0;
  }

  /// The data checksum.
  String checksum;

  /// The execution count.
  int executionCount;

  /// The line number.
  int lineNumber;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'checksum': checksum,
    'hit': executionCount,
    'line': lineNumber
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var value = '${Token.lineData}:$lineNumber,$executionCount';
    return checksum != null ? '$value,$checksum' : value;
  }
}
