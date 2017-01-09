part of lcov;

/// Provides the coverage data of functions.
class FunctionCoverage {

  /// Creates a new function coverage.
  FunctionCoverage({this.data = const [], this.found = 0, this.functions = const [], this.hit = 0});

  /// Creates a new function coverage from the specified [map] in JSON format.
  FunctionCoverage.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    data = map['data'] is List<Map<String, dynamic>> ? map['data'].map((map) => new FunctionData.fromJson(map)).toList() : [];
    found = map['found'] is int ? map['found'] : 0;
    functions = map['functions'] is List<Map<String, dynamic>> ? map['functions'].map((map) => new FunctionDef.fromJson(map)).toList() : [];
    hit = map['hit'] is int ? map['hit'] : 0;
  }

  /// The coverage data.
  List<FunctionData> data;

  /// The number of functions found.
  int found;

  /// The map of the line numbers of function start and the corresponding function names.
  List<FunctionDef> functions;

  /// The number of functions hit.
  int hit;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'data': data != null ? data.map((item) => item.toJson()).toList() : [],
    'found': found,
    'functions': functions != null ? functions.map((item) => item.toJson()).toList() : [],
    'hit': hit
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var lines = [];
    if (functions != null) lines.addAll(functions.map((item) => item.toString()));
    if (data != null) lines.addAll(data.map((item) => item.toString()));
    lines.add('${Token.functionsFound}:$found');
    lines.add('${Token.functionsHit}:$hit');
    return lines.join('\n');
  }
}

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function data.
  FunctionData({this.executionCount = 0, this.functionName});

  /// Creates a new function data from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    executionCount = map['hit'] is int ? map['hit'] : 0;
    functionName = map['name'] != null ? map['name'].toString() : null;
  }

  /// The execution count.
  int executionCount;

  /// The function name.
  String functionName;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'hit': executionCount,
    'name': functionName
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '${Token.functionData}:$executionCount,$functionName';
}

/// TODO Merge this class with [FunctionData] class.
class FunctionDef {

  /// Creates a new function coverage entry.
  FunctionDef({this.lineNumber = 0, this.name});

  /// Creates a new function coverage entry from the specified [map] in JSON format.
  FunctionDef.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    lineNumber = map['line'] is int ? map['line'] : 0;
    name = map['name'] != null ? map['name'].toString() : null;
  }

  /// The line number of the function start.
  int lineNumber;

  /// The function name.
  String name;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'line': lineNumber,
    'name': name
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '${Token.functionName}:$lineNumber,$name';
}
