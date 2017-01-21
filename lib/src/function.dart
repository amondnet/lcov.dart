part of lcov;

/// Provides the coverage data of functions.
class FunctionCoverage {

  /// Creates a new function coverage.
  FunctionCoverage();

  /// Creates a new function coverage from the specified [map] in JSON format.
  FunctionCoverage.fromJson(Map<String, dynamic> map) {
    if (map['data'] is List<Map<String, dynamic>>) data.addAll(map['data'].map((item) => new FunctionData.fromJson(item)));
    if (map['found'] is int) found = map['found'];
    if (map['hit'] is int) hit = map['hit'];
  }

  /// The coverage data.
  final List<FunctionData> data = [];

  /// The number of functions found.
  int found = 0;

  /// The number of functions hit.
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
    if (data.isNotEmpty) {
      buffer..writeAll(data.map((item) => item.toString(asDefinition: true)), '\n')..writeln();
      buffer..writeAll(data.map((item) => item.toString(asDefinition: false)), '\n')..writeln();
    }

    buffer.writeln('${Token.functionsFound}:$found');
    buffer.write('${Token.functionsHit}:$hit');
    return buffer.toString();
  }
}

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function data.
  FunctionData();

  /// Creates a new function data from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map) {
    if (map['executionCount'] is int) executionCount = map['executionCount'];
    if (map['functionName'] is String) functionName = map['functionName'];
    if (map['lineNumber'] is int) lineNumber = map['lineNumber'];
  }

  /// The execution count.
  int executionCount = 0;

  /// The function name.
  String functionName = '';

  /// The line number of the function start.
  int lineNumber = 0;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'executionCount': executionCount,
    'functionName': functionName,
    'lineNumber': lineNumber
  };

  /// Returns a string representation of this object.
  ///
  /// The [asDefinition] parameter indicates whether to return the function definition (e.g. name and line number)
  /// instead of its data (e.g. name and execution count).
  @override
  String toString({bool asDefinition = false}) {
    var token = asDefinition ? Token.functionName : Token.functionData;
    var number = asDefinition ? lineNumber : executionCount;
    return '$token:$number,$functionName';
  }
}
