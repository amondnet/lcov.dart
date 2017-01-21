part of lcov;

/// Provides the coverage data of lines.
class LineCoverage {

  /// Creates a new line coverage.
  LineCoverage();

  /// Creates a new line coverage from the specified [map] in JSON format.
  LineCoverage.fromJson(Map<String, dynamic> map) {
    if (map['data'] is List<Map<String, dynamic>>) data.addAll(map['data'].map((item) => new LineData.fromJson(item)));
    if (map['found'] is int) found = map['found'];
    if (map['hit'] is int) hit = map['hit'];
  }

  /// The coverage data.
  final List<LineData> data = [];

  /// The number of instrumented lines.
  int found = 0;

  /// The number of lines with a non-zero execution count.
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
    buffer.writeln('${Token.linesFound}:$found');
    buffer.write('${Token.linesHit}:$hit');
    return buffer.toString();
  }
}

/// Provides details for line coverage.
class LineData {

  /// Creates a new line data.
  LineData();

  /// Creates a new line data from the specified [map] in JSON format.
  LineData.fromJson(Map<String, dynamic> map) {
    if (map['checksum'] is String) checksum = map['checksum'];
    if (map['executionCount'] is int) executionCount = map['executionCount'];
    if (map['lineNumber'] is int) lineNumber = map['lineNumber'];
  }

  /// The data checksum.
  String checksum = '';

  /// The execution count.
  int executionCount = 0;

  /// The line number.
  int lineNumber = 0;

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
