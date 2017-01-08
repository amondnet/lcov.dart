part of lcov;

/// Provides the coverage data of functions.
class FunctionCoverage {

  /// Creates a new function coverage.
  FunctionCoverage({this.data = const [], this.found = 0, this.functions = const {}, this.hit = 0});

  /// Creates a new function coverage from the specified [map] in JSON format.
  FunctionCoverage.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    data = map['data'] is List<Map<String, dynamic>> ? map['data'].map((map) => new FunctionData.fromJson(map)).toList() : [];
    found = map['found'] is int ? map['found'] : 0;
    functions = map['functions'] is Map<String, String> ? new Map.fromIterable(map['functions'], key: (item) => int.parse(item, radix: 10)) : {};
    hit = map['hit'] is int ? map['hit'] : 0;
  }

  /// The coverage data.
  List<FunctionData> data;

  /// The number of functions found.
  int found;

  /// The map of the line numbers of function start and the corresponding function names.
  Map<int, String> functions;

  /// The number of functions hit.
  int hit;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'data': data != null ? data.map((item) => item.toJson()).toList() : [],
    'found': found,
    'functions': functions,
    'hit': hit
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var lines = [];
    if (functions != null) lines.addAll(functions.keys.map((key) => '${Token.functionName}:$key,${functions[key]}'));
    if (data != null) lines.addAll(data.map((item) => item.toString()));
    lines.add('${Token.functionsFound}:$found');
    lines.add('${Token.functionsHit}:$hit');
    return lines.join('\n');
  }
}

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function coverage entry.
  FunctionData({this.executionCount = 0, this.functionName});

  /// Creates a new function coverage entry from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    executionCount = map['count'] is int ? map['count'] : 0;
    functionName = map['name'] != null ? map['name'].toString() : null;
  }

  /// The execution count.
  int executionCount;

  /// The function name.
  String functionName;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'count': executionCount,
    'name': functionName
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '${Token.functionData}:$executionCount,$functionName';
}
