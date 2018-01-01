part of lcov;

/// Provides the coverage data of functions.
class FunctionCoverage {

  /// Creates a new function coverage.
  FunctionCoverage([this.found = 0, this.hit = 0, List<FunctionData> data]): data = new List.from(data ?? const <FunctionData>[]);

  /// Creates a new function coverage from the specified [map] in JSON format.
  FunctionCoverage.fromJson(Map<String, dynamic> map):
    data = map['data'] is List<Map<String, int>> ? map['data'].map((item) => new FunctionData.fromJson(item)).toList() : [],
    found = map['found'] is int ? map['found'] : 0,
    hit = map['hit'] is int ? map['hit'] : 0;

  /// The coverage data.
  final List<FunctionData> data;

  /// The number of functions found.
  int found;

  /// The number of functions hit.
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
    var buffer = new StringBuffer();
    if (data.isNotEmpty) buffer
      ..writeAll(data.map<String>((item) => item.toString(asDefinition: true)), '\n')..writeln()
      ..writeAll(data.map<String>((item) => item.toString(asDefinition: false)), '\n')..writeln();

    buffer
      ..writeln('${Token.functionsFound}:$found')
      ..write('${Token.functionsHit}:$hit');

    return buffer.toString();
  }
}

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function data.
  FunctionData(this.functionName, this.lineNumber, {this.executionCount = 0});

  /// Creates a new function data from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map):
    executionCount = map['executionCount'] is int ? map['executionCount'] : 0,
    functionName = map['functionName'] is String ? map['functionName'] : '',
    lineNumber = map['lineNumber'] is int ? map['lineNumber'] : 0;

  /// The execution count.
  int executionCount;

  /// The function name.
  final String functionName;

  /// The line number of the function start.
  final int lineNumber;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'functionName': functionName,
    'lineNumber': lineNumber,
    'executionCount': executionCount
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
