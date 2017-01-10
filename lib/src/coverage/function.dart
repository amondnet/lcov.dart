part of lcov;

/// Provides the coverage data of functions.
class FunctionCoverage {

  /// Creates a new function coverage.
  FunctionCoverage({this.data = const [], this.found = 0, this.hit = 0});

  /// Creates a new function coverage from the specified [map] in JSON format.
  FunctionCoverage.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    data = map['details'] is List<Map<String, dynamic>> ? map['details'].map((map) => new FunctionData.fromJson(map)).toList() : [];
    found = map['found'] is int ? map['found'] : 0;
    hit = map['hit'] is int ? map['hit'] : 0;
  }

  /// The coverage data.
  List<FunctionData> data;

  /// The number of functions found.
  int found;

  /// The number of functions hit.
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
    lines.add('${Token.functionsFound}:$found');
    lines.add('${Token.functionsHit}:$hit');
    return lines.join('\n');
  }
}

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function data.
  FunctionData({this.executionCount = 0, this.functionName, this.lineNumber = 0});

  /// Creates a new function data from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    executionCount = map['hit'] is int ? map['hit'] : 0;
    functionName = map['name'] != null ? map['name'].toString() : null;
    lineNumber = map['hit'] is int ? map['hit'] : 0;
  }

  /// The execution count.
  int executionCount;

  /// The function name.
  String functionName;

  /// The line number of the function start.
  int lineNumber;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'hit': executionCount,
    'line': lineNumber,
    'name': functionName
  };

  /// Returns a string representation of this object.
  /// The [asDefinition] parameter indicates whether to return the function definition (e.g. name and line number) instead of its data (e.g. name and execution count).
  @override
  String toString([bool asDefinition = false]) {
    var token = asDefinition ? Token.functionName : Token.functionData;
    var number = asDefinition ? lineNumber : executionCount;
    return '$token:$number,$functionName';
  }
}
